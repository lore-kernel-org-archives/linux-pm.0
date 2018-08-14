From: Steve Muckle <smuckle@google.com>
Subject: Re: [RFC] vruntime updated incorrectly when rt_mutex boots prio?
Date: Mon, 13 Aug 2018 17:05:07 -0700
Message-ID: <afe2ae95-104f-4b14-c19d-de9bafeef5f2@google.com>
References: <CA+njcd3z7-jqLvhsBjNWUO9bDrMr_zd13CD2cPdCS0+_kXdc4g@mail.gmail.com>
 <CAHRSSEwd0Ma+wn3WYCvfWMwg3E8vzYx9CDOOiY63EzH42FZQvg@mail.gmail.com>
 <CAHRSSEwdWhUurOkviS0WdcGKj3374r-nCXH3BkQfwFiObyq+4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHRSSEwdWhUurOkviS0WdcGKj3374r-nCXH3BkQfwFiObyq+4w@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Todd Kjos <tkjos@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Paul Turner <pjt@google.com>
Cc: John Dias <joaodias@google.com>, Quentin Perret <quentin.perret@arm.com>, Patrick Bellasi <Patrick.Bellasi@arm.com>, Chris Redpath <Chris.Redpath@arm.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, Android Kernel Team <kernel-team@android.com>
List-Id: linux-pm@vger.kernel.org

On 08/07/2018 10:40 AM, 'Todd Kjos' via kernel-team wrote:
> This issue was discovered on a 4.9-based android device, but the
> relevant mainline code appears to be the same. The symptom is that
> over time the some workloads become sluggish resulting in missed
> frames or sluggishness. It appears to be the same issue described in
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-March/567836.html.
> 
> Here is the scenario: A task is deactivated while still in the fair
> class. The task is then boosted to RT, so rt_mutex_setprio() is
> called. This changes the task to RT and calls check_class_changed(),
> which eventually calls detach_task_cfs_rq(), which is where
> vruntime_normalized() sees that the task's state is TASK_WAKING, which
> results in skipping the subtraction of the rq's min_vruntime from the
> task's vruntime. Later, when the prio is deboosted and the task is
> moved back to the fair class, the fair rq's min_vruntime is added to
> the task's vruntime, resulting in vruntime inflation.

This was reproduced for me on tip of mainline by using the program at 
the end of this mail. It was run in a 2 CPU virtualbox VM. Relevant 
annotated bits of the trace:

low-prio thread vruntime is 752ms
  pi-vruntime-tes-598   [001] d...   520.572459: sched_stat_runtime: 
comm=pi-vruntime-tes pid=598 runtime=29953 [ns] vruntime=752888705 [ns]

low-prio thread waits on a_sem
  pi-vruntime-tes-598   [001] d...   520.572465: sched_switch: 
prev_comm=pi-vruntime-tes prev_pid=598 prev_prio=120 prev_state=D ==> 
next_comm=swapper/1 next_pid=0 next_prio=120

high prio thread finishes wakeup, then sleeps for 1ms
           <idle>-0     [000] dNh.   520.572483: sched_wakeup: 
comm=pi-vruntime-tes pid=597 prio=19 target_cpu=000
           <idle>-0     [000] d...   520.572486: sched_switch: 
prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=S ==> 
next_comm=pi-vruntime-tes next_pid=597 next_prio=19
  pi-vruntime-tes-597   [000] d...   520.572498: sched_switch: 
prev_comm=pi-vruntime-tes prev_pid=597 prev_prio=19 prev_state=D ==> 
next_comm=swapper/0 next_pid=0 next_prio=120

high prio thread wakes up after 1ms sleep, posts a_sem which starts to 
wake low-prio thread, then tries to grab pi_mutex, which low-prio thread has
           <idle>-0     [000] d.h.   520.573876: sched_waking: 
comm=pi-vruntime-tes pid=597 prio=19 target_cpu=000
           <idle>-0     [000] dNh.   520.573879: sched_wakeup: 
comm=pi-vruntime-tes pid=597 prio=19 target_cpu=000
           <idle>-0     [000] d...   520.573887: sched_switch: 
prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=S ==> 
next_comm=pi-vruntime-tes next_pid=597 next_prio=19
  pi-vruntime-tes-597   [000] d...   520.573895: sched_waking: 
comm=pi-vruntime-tes pid=598 prio=120 target_cpu=001

low-prio thread pid 598 gets pi_mutex priority inheritance, this happens 
while low-prio thread is in waking state
  pi-vruntime-tes-597   [000] d...   520.573911: sched_pi_setprio: 
comm=pi-vruntime-tes pid=598 oldprio=120 newprio=19

high-prio thread sleeps on pi_mutex
  pi-vruntime-tes-597   [000] d...   520.573919: sched_switch: 
prev_comm=pi-vruntime-tes prev_pid=597 prev_prio=19 prev_state=D ==> 
next_comm=swapper/0 next_pid=0 next_prio=120

low-prio thread finishes wakeup
           <idle>-0     [001] dNh.   520.573932: sched_wakeup: 
comm=pi-vruntime-tes pid=598 prio=19 target_cpu=001
           <idle>-0     [001] d...   520.573936: sched_switch: 
prev_comm=swapper/1 prev_pid=0 prev_prio=120 prev_state=S ==> 
next_comm=pi-vruntime-tes next_pid=598 next_prio=19

low-prio thread releases pi-mutex, loses pi boost, high-prio thread 
wakes for pi-mutex
  pi-vruntime-tes-598   [001] d...   520.573946: sched_pi_setprio: 
comm=pi-vruntime-tes pid=598 oldprio=19 newprio=120
  pi-vruntime-tes-598   [001] dN..   520.573954: sched_waking: 
comm=pi-vruntime-tes pid=597 prio=19 target_cpu=000

low-prio thread vruntime is 1505ms
  pi-vruntime-tes-598   [001] dN..   520.573966: sched_stat_runtime: 
comm=pi-vruntime-tes pid=598 runtime=20150 [ns] vruntime=1505797560 [ns]

The program:

/*
  * Test case for vruntime management during rtmutex priority inheritance
  * promotion and demotion.
  *
  * build with -lpthread
  */

#define _GNU_SOURCE
#include <pthread.h>
#include <semaphore.h>
#include <sched.h>
#include <stdio.h>
#include <unistd.h>

#define ERROR_CHECK(x) \
         if (x) \
                 fprintf(stderr, "Error at line %d", __LINE__);

pthread_mutex_t pi_mutex;
sem_t a_sem;
sem_t b_sem;

void *rt_thread_func(void *arg) {
         int policy;
         int i = 0;
         cpu_set_t cpuset;

         CPU_ZERO(&cpuset);
         CPU_SET(0, &cpuset);
         ERROR_CHECK(pthread_setaffinity_np(pthread_self(), 
sizeof(cpu_set_t),
                                            &cpuset));

         while(i++ < 100) {
                 sem_wait(&b_sem);
                 usleep(1000);
                 sem_post(&a_sem);
                 pthread_mutex_lock(&pi_mutex);
                 pthread_mutex_unlock(&pi_mutex);
         }
}

void *low_prio_thread_func(void *arg) {
         int i = 0;
         cpu_set_t cpuset;

         CPU_ZERO(&cpuset);
         CPU_SET(1, &cpuset);
         ERROR_CHECK(pthread_setaffinity_np(pthread_self(), 
sizeof(cpu_set_t),
                                            &cpuset));
         while(i++ < 100) {
                 pthread_mutex_lock(&pi_mutex);
                 sem_post(&b_sem);
                 sem_wait(&a_sem);
                 pthread_mutex_unlock(&pi_mutex);
         }
}

int main()
{
         pthread_t rt_thread;
         pthread_t low_prio_thread;
         pthread_attr_t rt_thread_attrs;
         pthread_attr_t low_prio_thread_attrs;
         struct sched_param rt_thread_sched_params;
         struct sched_param low_prio_thread_sched_params;

         pthread_mutexattr_t mutex_attrs;

         sem_init(&a_sem, 0, 0);
         sem_init(&b_sem, 0, 0);

         ERROR_CHECK(pthread_mutexattr_init(&mutex_attrs));
         ERROR_CHECK(pthread_mutexattr_setprotocol(&mutex_attrs,
                                                   PTHREAD_PRIO_INHERIT));
         ERROR_CHECK(pthread_mutex_init(&pi_mutex, &mutex_attrs));

         rt_thread_sched_params.sched_priority = 80;
         low_prio_thread_sched_params.sched_priority = 0;

         pthread_attr_init(&rt_thread_attrs);
         pthread_attr_init(&low_prio_thread_attrs);

         ERROR_CHECK(pthread_attr_setinheritsched(&rt_thread_attrs,
                                                  PTHREAD_EXPLICIT_SCHED));
         ERROR_CHECK(pthread_attr_setinheritsched(&low_prio_thread_attrs,
                                                  PTHREAD_EXPLICIT_SCHED));

         ERROR_CHECK(pthread_attr_setschedpolicy(&rt_thread_attrs,
                                                 SCHED_FIFO));
         ERROR_CHECK(pthread_attr_setschedpolicy(&low_prio_thread_attrs,
                                                 SCHED_OTHER));

         ERROR_CHECK(pthread_attr_setschedparam(&rt_thread_attrs,
                                                &rt_thread_sched_params));
         ERROR_CHECK(pthread_attr_setschedparam(&low_prio_thread_attrs,
 
&low_prio_thread_sched_params));

         ERROR_CHECK(pthread_create(&rt_thread, &rt_thread_attrs,
                                    rt_thread_func, NULL));
         ERROR_CHECK(pthread_create(&low_prio_thread, 
&low_prio_thread_attrs,
                                    low_prio_thread_func, NULL));

         ERROR_CHECK(pthread_join(rt_thread, NULL));
         ERROR_CHECK(pthread_join(low_prio_thread, NULL));

         return 0;
}
