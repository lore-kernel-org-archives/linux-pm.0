From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Thu, 18 Jun 2015 22:35:44 -0400
Message-ID: <CAJvTdKkJoSFUpBvCG0kEaTWti7EpPmficUxXZg49cb0QJD3A6w@mail.gmail.com>
References: <b1587e8b2c664632ecd0d9ad1a3e56733da76490.1431068823.git.len.brown@intel.com>
	<20150514092251.6d0625af@notabene.brown>
	<20150514235426.GF4316@dastard>
	<3798672.EXej90jOp1@vostro.rjw.lan>
	<CACVXFVMEwOSeP8FM89E4XZPUhDsP6bfeCGmJDK1i5kKs-3MCDg@mail.gmail.com>
	<CAJZ5v0gvDCwXWc5aAU7dGDsC=8ZbGBhQHgPkP92W=+Z7-v_2wA@mail.gmail.com>
	<20150515113557.54ef930b@lxorguk.ukuu.org.uk>
	<20150518115727.72439610@notabene.brown>
	<CAJvTdKn_0EZ0ZuqO2e4+ExD8kFWcy78fse4zHr3uFZODOroXEg@mail.gmail.com>
	<20150619010955.GL20262@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150619010955.GL20262@dastard>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: NeilBrown <neilb@suse.de>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "Rafael J. Wysocki" <rafael@kernel.org>, Ming Lei <tom.leiming@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 18, 2015 at 9:09 PM, Dave Chinner <david@fromorbit.com> wrote:
> On Thu, Jun 18, 2015 at 02:14:31AM -0400, Len Brown wrote:
>> On Sun, May 17, 2015 at 9:57 PM, NeilBrown <neilb@suse.de> wrote:
>> > On Fri, 15 May 2015 11:35:57 +0100 One Thousand Gnomes
>> > <gnomes@lxorguk.ukuu.org.uk> wrote:
>> >
>> >> > > Data loss may be caused for hotplug storage(like USB), or all storage
>> >> > > when power is exhausted during suspend.
>> >> >
>> >> > Which also may very well happen at run time, right?
>> >>
>> >> Intuitively users treat "suspended" as a bit like off and do remove
>> >> devices they've "finished with".
>> >>
>> >> Technically yes the instant off/on on a phone is the same as the suspend
>> >> to RAM on a laptop but it doesn't mean the model in people's heads is the
>> >> same... not yet anyway.
>> >>
>> >> > > Is there obvious advantage to remove sys_sync() in the case?
>> >> >
>> >> > Yes, there is.  It is not necessary to sync() every time you suspend
>> >> > if you do that very often.
>> >>
>> >> But if you do it very often you won't have any dirty pages to flush so it
>> >> will be very fast.
>> >
>> > Several people have said things like this, and yet Len clearly saw a problem
>> > so sometimes it isn't as fast as you think it should be.  I guess we need
>> > some data.
>> >
>> > In fact there seem to be a number of open questions:
>> >
>> > 1/ Len has seen enough delays to bother sending a patch.  Twice.  Lots of
>> >    other people claim there shouldn't be much delay.
>> >
>> >    Len: can you provide numbers?  How long does the sys_sync take
>> >    (min/max/mean....).  I think an interesting number would be in a quick
>> >    "resume, do something, suspend" cycle, what percent of the time is spent
>> >    in sys_sync.
>> >    Maybe also report what filesystems are in use, and whether you expect
>> >    there to be any dirty data.
>> >
>> >    If I run "time sync; time sync; time sync" it reports about 50msec for
>> >    each sync.  If I run "time sleep 0; time sleep 0; time sleep 0" it reports
>> >    about 2 msec.  So sys_sync is taking at least 50msec.
>> >    Almost all of that is in sync_inodes_sb() and much of that is in
>> >    _raw_spin_lock.... though I might be misinterpreting perf.  It seems to
>> >    wait for a BDI flusher thread to go off and do nothing.
>> >
>> >    Len: is 50msec enough to bother you?
>>
>> 50ms is not acceptable.
>> 5ms is also not acceptable.
>>
>> If it were guaranteed to be under 1ms, it would not behigh  on my
>> "performance pain" list, but I would still require the option
>> to delete it entirely.
>>
>> But sys_sync time is random on  many systems,
>> with a very large maximum duration.
>>
>> Attached is the output from analyze_suspend.py -x2
>> on a desktop machine, which has just an inexpensive SSD for storage.
>> It is a fresh install of Fedora 22 with a stock 4.0.4-301 kernel
>> with no tweaks.
>
> More information required. Mounted filesystems, mount options, etc
> at minimum so we have some idea of what is being synced. We don't
> even know what filesystem you are using....

In this case, I am using Fedora 22 defaults on a single SSD:

ext4 (rw,relatime,seclabel,data=ordered)


[lenb@d975xbx ~]$ mount
/dev/sda3 on / type ext4 (rw,relatime,seclabel,data=ordered)
devtmpfs on /dev type devtmpfs (rw,relatime,seclabel,size=3053436k,nr_inodes=76)
sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime,seclabel)
proc on /proc type proc (rw,nosuid,nodev,noexec,relatime)
securityfs on /sys/kernel/security type securityfs (rw,nosuid,nodev,noexec,rela)
selinuxfs on /sys/fs/selinux type selinuxfs (rw,relatime)
tmpfs on /dev/shm type tmpfs (rw,nosuid,nodev,seclabel)
devpts on /dev/pts type devpts (rw,nosuid,noexec,relatime,seclabel,gid=5,mode=6)
tmpfs on /run type tmpfs (rw,nosuid,nodev,seclabel,mode=755)
tmpfs on /sys/fs/cgroup type tmpfs (ro,nosuid,nodev,noexec,seclabel,mode=755)
cgroup on /sys/fs/cgroup/systemd type cgroup (rw,nosuid,nodev,noexec,relatime,x)
pstore on /sys/fs/pstore type pstore (rw,nosuid,nodev,noexec,relatime,seclabel)
cgroup on /sys/fs/cgroup/cpuset type cgroup (rw,nosuid,nodev,noexec,relatime,cp)
cgroup on /sys/fs/cgroup/perf_event type cgroup (rw,nosuid,nodev,noexec,relatim)
cgroup on /sys/fs/cgroup/net_cls,net_prio type cgroup (rw,nosuid,nodev,noexec,r)
cgroup on /sys/fs/cgroup/blkio type cgroup (rw,nosuid,nodev,noexec,relatime,blk)
cgroup on /sys/fs/cgroup/hugetlb type cgroup (rw,nosuid,nodev,noexec,relatime,h)
cgroup on /sys/fs/cgroup/cpu,cpuacct type cgroup (rw,nosuid,nodev,noexec,relati)
cgroup on /sys/fs/cgroup/memory type cgroup (rw,nosuid,nodev,noexec,relatime,me)
cgroup on /sys/fs/cgroup/devices type cgroup (rw,nosuid,nodev,noexec,relatime,d)
cgroup on /sys/fs/cgroup/freezer type cgroup (rw,nosuid,nodev,noexec,relatime,f)
systemd-1 on /proc/sys/fs/binfmt_misc type autofs (rw,relatime,fd=21,pgrp=1,tim)
debugfs on /sys/kernel/debug type debugfs (rw,relatime,seclabel)
hugetlbfs on /dev/hugepages type hugetlbfs (rw,relatime,seclabel)
tmpfs on /tmp type tmpfs (rw,seclabel)
mqueue on /dev/mqueue type mqueue (rw,relatime,seclabel)
configfs on /sys/kernel/config type configfs (rw,relatime)
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw,relatime)
nfsd on /proc/fs/nfsd type nfsd (rw,relatime)
/dev/sda1 on /boot type ext4 (rw,relatime,seclabel,data=ordered)
tmpfs on /run/user/1000 type tmpfs (rw,nosuid,nodev,relatime,seclabel,size=6109)
tracefs on /sys/kernel/debug/tracing type tracefs (rw,relatime)


>> The 1st suspend starts with a sync that takes 6.6ms
>> But the 2nd suspend starts with a sync that takes 451.8ms
>
> The graph posted just has a single box labelled "sync_filesystems"
> with no other information about what is actually taking that time.
> We need to know what is consuming all that time *inside*
> sync_filesystems() to make any progress here.

Just for grins, did 100 sys_sync instead of one.
They all ran about the same 5ms.
While they were all to slow, none of them were
 O(500ms), so yes, there
does seem to be some state change
that causes the 2nd sync after a resume to be especially slow.

Unfortunately, I've not got an ftrace on the 500ms flavor yet.


>> So the reasoning that subsequent sys_sync's should be instantly quick
>> because they are following a previous sys_sync is found to be simply
>> erroneous by observations such as this.
>
> Which indicates that either the system is not idle as expected, or
> there's some kind of bug in one of the filesystems that is being
> synced.

the system is idle.

>
> But we can't do any analysis of the problem you are seeing if the
> only information you give us "it takes too long".

I'm happy to help debug why sync is sometimes extremely slow.
But the fact remains that even when it is fast, it is too slow,
and should not be hard-coded in the suspend path.

> Something like a
> function trace that tells use exactly what functions are being
> called and how long they take to execute would be really handy
> here.
>
> Alternatively, you don't need to suspend to test this - just run a
> test program on an idle system that does two sync() calls 50ms apart
> and see what happens. If you can't reproduce it outside of a suspend
> operation, then we need to look at what suspend is actually causing
> to be dirtied in those 50ms.

how about something like this:

>From single user mode:

[root@d975xbx ~]# cat ./do.sync
cd /sys/kernel/debug/tracing

echo 0 > tracing_on
echo global > trace_clock
echo 100000 > buffer_size_kb
echo function_graph > current_tracer
echo 1 > options/funcgraph-tail
echo 1 > options/funcgraph-abstime
echo 1 > options/funcgraph-proc

echo 8 > max_graph_depth
echo sys_sync > set_graph_function

for a in 0 1 2 3 4 5 6 7 8 9 ; do
echo  > trace
sync
sleep .05
cp trace ~lenb/trace.$a
done

cd ~lenb
grep sys_sync trace.*

[root@d975xbx ~]# grep sys_sync trace.*
trace.0: 3353.150723 |   0)   sync-9346    |               |  sys_sync() {
trace.0: 3353.170781 |   0)   sync-9346    | # 20050.69 us |  } /* sys_sync */
trace.1: 3353.358415 |   0)   sync-9349    |               |  sys_sync() {
trace.1: 3353.446597 |   1)   sync-9349    | # 88159.41 us |  } /* sys_sync */
trace.2: 3353.639402 |   0)   sync-9353    |               |  sys_sync() {
trace.2: 3353.728769 |   1)   sync-9353    | # 89342.61 us |  } /* sys_sync */
trace.3: 3353.914381 |   1)   sync-9356    |               |  sys_sync() {
trace.3: 3354.003319 |   1)   sync-9356    | # 88915.31 us |  } /* sys_sync */
trace.4: 3354.199339 |   1)   sync-9359    |               |  sys_sync() {
trace.4: 3354.287795 |   1)   sync-9359    | # 88433.31 us |  } /* sys_sync */
trace.5: 3354.479363 |   0)   sync-9362    |               |  sys_sync() {
trace.5: 3354.568357 |   1)   sync-9362    | # 88971.71 us |  } /* sys_sync */
trace.6: 3354.762365 |   0)   sync-9365    |               |  sys_sync() {
trace.6: 3354.851681 |   0)   sync-9365    | # 89292.67 us |  } /* sys_sync */
trace.7: 3355.038391 |   0)   sync-9368    |               |  sys_sync() {
trace.7: 3355.127130 |   0)   sync-9368    | # 88715.66 us |  } /* sys_sync */
trace.8: 3355.311360 |   0)   sync-9371    |               |  sys_sync() {
trace.8: 3355.398359 |   0)   sync-9371    | # 86976.54 us |  } /* sys_sync */
trace.9: 3355.588336 |   0)   sync-9374    |               |  sys_sync() {
trace.9: 3355.676756 |   0)   sync-9374    | # 88397.52 us |  } /* sys_sync */

# grep \# trace.5
# tracer: function_graph
#
#     TIME        CPU  TASK/PID         DURATION                  FUNCTION CALLS
#      |          |     |    |           |   |                     |   |   |   |
 3354.479519 |   0)   sync-9362    | # 1887.858 us |
__schedule();
 3354.481409 |   0)   sync-9362    | # 1889.459 us |              } /*
schedule */
 3354.481409 |   0)   sync-9362    | # 1890.467 us |            } /*
schedule_timeout */
 3354.481411 |   0)   sync-9362    | # 1894.576 us |          } /*
wait_for_completion */
 3354.481420 |   0)   sync-9362    | # 13762.41 us |
__wait_on_bit();
 3354.495187 |   0)   sync-9362    | # 13763.64 us |              } /*
wait_on_page_bit */
 3354.495196 |   0)   sync-9362    | # 16248.52 us |
__wait_on_bit();
 3354.511449 |   0)   sync-9362    | # 16249.50 us |              } /*
wait_on_page_bit */
 3354.511455 |   0)   sync-9362    | # 17580.20 us |
__wait_on_bit();
 3354.529041 |   0)   sync-9362    | # 17581.19 us |              } /*
wait_on_page_bit */
 3354.529047 |   0)   sync-9362    | # 16214.36 us |
__wait_on_bit();
 3354.545266 |   0)   sync-9362    | # 16215.31 us |              } /*
wait_on_page_bit */
 3354.545272 |   0)   sync-9362    | # 6439.709 us |
__wait_on_bit();
 3354.551715 |   0)   sync-9362    | # 6440.856 us |              } /*
wait_on_page_bit */
 3354.551723 |   0)   sync-9362    | # 70289.60 us |            } /*
filemap_fdatawait_range */
 3354.551723 |   0)   sync-9362    | # 70290.64 us |          } /*
filemap_fdatawait */
 3354.567133 |   0)   sync-9362    | # 87611.58 us |        } /*
sync_inodes_sb */
 3354.567133 |   0)   sync-9362    | # 87612.32 us |      } /*
sync_inodes_one_sb */
 3354.567251 |   0)   sync-9362    | # 87831.46 us |    } /* iterate_supers */
 3354.568357 |   1)   sync-9362    | # 88971.71 us |  } /* sys_sync */

That is where the time is going in the "normal" case.

cheers,
-Len

>
> If you can reproduce it, you can then even narrow down the
> filesystem that is causing the problem by using syncfs() instead of
> sync() to test the filesystems one at a time, and once you've done
> that take a writeback event trace so we can see exactly what
> inodes/data is being written back, and hence identify what the first
> sync is not cleaning.
>
> FWIW, I'd also suggest trying the changes to the sync code here:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/josef/btrfs-next.git superblock-scaling
>
> As they avoid the need for sync to walk all the cached inodes
> in the system needlessly and so should reduce the CPU overhead of
> sys_sync() quite substantially.
>
> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com



-- 
Len Brown, Intel Open Source Technology Center
