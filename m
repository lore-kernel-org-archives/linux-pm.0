From: Yogesh Ahire <yogesh02061983@gmail.com>
Subject: sched_yield() call on Linux Kernel 2.6.39 is not behaving correctly
Date: Wed, 7 Jan 2015 16:36:27 -0500
Message-ID: <CAH86sK+0fMKpkRAkPOt_oXGynhi6605w1acxWyXqywP3Cs4TTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi All,

I have a system with multiple CPU cores.  I have multiple threads
assigned to particular CPU. Among these threads the main thread calls
sched_yield() if it has nothing to do, I am hoping that doing so will
give chance to other threads to run. But the strange behavior of
sched_yield() is , even if there are ready-to-runs tasks on this CPU
waiting for their turn, the task which calls sched_yield() is always
running ( get scheduled) and not giving chance to any other task to
run. It is consuming 100% of CPU. Is sched_yield() is broken on 2.6
Kernel?


Thanks
Yogesh
