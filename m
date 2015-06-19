From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Fri, 19 Jun 2015 14:31:47 +1000
Message-ID: <20150619043147.GA16870@dastard>
References: <20150514092251.6d0625af@notabene.brown>
 <20150514235426.GF4316@dastard>
 <3798672.EXej90jOp1@vostro.rjw.lan>
 <CACVXFVMEwOSeP8FM89E4XZPUhDsP6bfeCGmJDK1i5kKs-3MCDg@mail.gmail.com>
 <CAJZ5v0gvDCwXWc5aAU7dGDsC=8ZbGBhQHgPkP92W=+Z7-v_2wA@mail.gmail.com>
 <20150515113557.54ef930b@lxorguk.ukuu.org.uk>
 <20150518115727.72439610@notabene.brown>
 <CAJvTdKn_0EZ0ZuqO2e4+ExD8kFWcy78fse4zHr3uFZODOroXEg@mail.gmail.com>
 <20150619010955.GL20262@dastard>
 <CAJvTdKkJoSFUpBvCG0kEaTWti7EpPmficUxXZg49cb0QJD3A6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJvTdKkJoSFUpBvCG0kEaTWti7EpPmficUxXZg49cb0QJD3A6w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: NeilBrown <neilb@suse.de>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "Rafael J. Wysocki" <rafael@kernel.org>, Ming Lei <tom.leiming@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 18, 2015 at 10:35:44PM -0400, Len Brown wrote:
> On Thu, Jun 18, 2015 at 9:09 PM, Dave Chinner <david@fromorbit.com> wrote:
> > On Thu, Jun 18, 2015 at 02:14:31AM -0400, Len Brown wrote:
> >> On Sun, May 17, 2015 at 9:57 PM, NeilBrown <neilb@suse.de> wrote:
> >> > 1/ Len has seen enough delays to bother sending a patch.  Twice.  Lots of
> >> >    other people claim there shouldn't be much delay.
> >> >
> >> >    Len: can you provide numbers?  How long does the sys_sync take
> >> >    (min/max/mean....).  I think an interesting number would be in a quick
> >> >    "resume, do something, suspend" cycle, what percent of the time is spent
> >> >    in sys_sync.
> >> >    Maybe also report what filesystems are in use, and whether you expect
> >> >    there to be any dirty data.
> >> >
> >> >    If I run "time sync; time sync; time sync" it reports about 50msec for
> >> >    each sync.  If I run "time sleep 0; time sleep 0; time sleep 0" it reports
> >> >    about 2 msec.  So sys_sync is taking at least 50msec.
> >> >    Almost all of that is in sync_inodes_sb() and much of that is in
> >> >    _raw_spin_lock.... though I might be misinterpreting perf.  It seems to
> >> >    wait for a BDI flusher thread to go off and do nothing.
> >> >
> >> >    Len: is 50msec enough to bother you?
> >>
> >> 50ms is not acceptable.
> >> 5ms is also not acceptable.
> >>
> >> If it were guaranteed to be under 1ms, it would not behigh  on my
> >> "performance pain" list, but I would still require the option
> >> to delete it entirely.
> >>
> >> But sys_sync time is random on  many systems,
> >> with a very large maximum duration.
> >>
> >> Attached is the output from analyze_suspend.py -x2
> >> on a desktop machine, which has just an inexpensive SSD for storage.
> >> It is a fresh install of Fedora 22 with a stock 4.0.4-301 kernel
> >> with no tweaks.
> >
> > More information required. Mounted filesystems, mount options, etc
> > at minimum so we have some idea of what is being synced. We don't
> > even know what filesystem you are using....
> 
> In this case, I am using Fedora 22 defaults on a single SSD:
> 
> ext4 (rw,relatime,seclabel,data=ordered)

OK, nothing unusual.

> [lenb@d975xbx ~]$ mount
> /dev/sda3 on / type ext4 (rw,relatime,seclabel,data=ordered)
....
> /dev/sda1 on /boot type ext4 (rw,relatime,seclabel,data=ordered)
....

And so effectively only a single filesystem that would do IO when
sync is called.

> > The graph posted just has a single box labelled "sync_filesystems"
> > with no other information about what is actually taking that time.
> > We need to know what is consuming all that time *inside*
> > sync_filesystems() to make any progress here.
> 
> Just for grins, did 100 sys_sync instead of one.
> They all ran about the same 5ms.

Ok, so what's the overhead? On one of my test VMs, running on
spinning disk backed devices and a single ext3 root filesystem and
running that sync scalability patch series:

> > git://git.kernel.org/pub/scm/linux/kernel/git/josef/btrfs-next.git superblock-scaling

$ for i in `seq 0 1 100`; do time sleep 0 ; done 2>&1 | stats

real    0m0.002s
user    0m0.000000-0.004000(0.000168317+/-0.00058)s
sys     0m0.000000-0.003000(0.00154455+/-0.00074)s
$ for i in `seq 0 1 100`; do time sync ; done 2>&1 | stats

real    0m0.002s
user    0m0.000000-0.002000(0.000118812+/-0.00041)s
sys     0m0.000000-0.003000(0.00151485+/-0.0007)s
$

The sync runtime is exactly the same as running "sleep 0" 100 times.
Without the sync scalability patchset:

$ for i in `seq 0 1 100`; do time sync ; done 2>&1 | stats

real  0m0.007s
user  0m0.000000-0.004000(0.000316832+/-0.00096)s
sys   0m0.003000-0.008000(0.00690099+/-0.00099)s
$

There's 5ms extra time on every sync, and it is entirely system CPU
time. That will be the inode cache traversal overhead.  To confirm,
drop the cache and rerun:

$ sudo grep ext3_inode /proc/slabinfo
ext3_inode_cache   23086  23086    960   17    4 : tunables    0    0    0 : slabdata   1358   1358      0
$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches "
$ sudo grep ext3_inode /proc/slabinfo
ext3_inode_cache    3152   4488    960   17    4 : tunables    0    0    0 : slabdata    264    264      0
$ for i in `seq 0 1 100`; do time sync ; done 2>&1 | stats

real  0m0.002s
user  0m0.000000-0.005000(0.000227723+/-0.00074)s
sys   0m0.000000-0.002000(0.00182178+/-0.00057)s

Dropping the inode cache (from 23,000 inodes to 3,000) makes the 5ms
sync runtime disappear.

Can you repeat this test on your system, so that we can determine if
the 5ms ""sync time" is actually just the overhead of inode cache
traversal? If that is the case, the speed of sync on a clean
filesystem is already a solved problem - the patchset should be
merged in the 4.2 cycle....

> While they were all to slow, none of them were
>  O(500ms), so yes, there
> does seem to be some state change
> that causes the 2nd sync after a resume to be especially slow.
> 
> Unfortunately, I've not got an ftrace on the 500ms flavor yet.

This is the problem we really need to reproduce and track down.

> >> So the reasoning that subsequent sys_sync's should be instantly quick
> >> because they are following a previous sys_sync is found to be simply
> >> erroneous by observations such as this.
> >
> > Which indicates that either the system is not idle as expected, or
> > there's some kind of bug in one of the filesystems that is being
> > synced.
> 
> the system is idle.

That doesn't mean the filesystem is idle (e.g. it could be cleaning
the log) or that nothing is dirtying the filesystem behind your back.

> > Something like a
> > function trace that tells use exactly what functions are being
> > called and how long they take to execute would be really handy
> > here.
> >
> > Alternatively, you don't need to suspend to test this - just run a
> > test program on an idle system that does two sync() calls 50ms apart
> > and see what happens. If you can't reproduce it outside of a suspend
> > operation, then we need to look at what suspend is actually causing
> > to be dirtied in those 50ms.
> 
> how about something like this:
> 
> From single user mode:
> 
> [root@d975xbx ~]# cat ./do.sync
> cd /sys/kernel/debug/tracing
> 
> echo 0 > tracing_on
> echo global > trace_clock
> echo 100000 > buffer_size_kb
> echo function_graph > current_tracer
> echo 1 > options/funcgraph-tail
> echo 1 > options/funcgraph-abstime
> echo 1 > options/funcgraph-proc
> 
> echo 8 > max_graph_depth
> echo sys_sync > set_graph_function
> 
> for a in 0 1 2 3 4 5 6 7 8 9 ; do
> echo  > trace
> sync
> sleep .05
> cp trace ~lenb/trace.$a

This dirties the filesystem on every loop. Which means the second
and subseqent sync calls are not running on a clean filesystem and
are issuing and waiting on IO.

> done
> 
> cd ~lenb
> grep sys_sync trace.*
> 
> [root@d975xbx ~]# grep sys_sync trace.*
> trace.0: 3353.150723 |   0)   sync-9346    |               |  sys_sync() {
> trace.0: 3353.170781 |   0)   sync-9346    | # 20050.69 us |  } /* sys_sync */

20ms, looks clean. Slow, probably due to the function tracer, but
otherwise seems fine.

> trace.1: 3353.358415 |   0)   sync-9349    |               |  sys_sync() {
> trace.1: 3353.446597 |   1)   sync-9349    | # 88159.41 us |  } /* sys_sync */

88ms, and every subsequent run takes that same time, because:

> # tracer: function_graph
> #
> #     TIME        CPU  TASK/PID         DURATION                  FUNCTION CALLS
> #      |          |     |    |           |   |                     |   |   |   |
>  3354.479519 |   0)   sync-9362    | # 1887.858 us | __schedule();
>  3354.481409 |   0)   sync-9362    | # 1889.459 us |              } /* schedule */
>  3354.481409 |   0)   sync-9362    | # 1890.467 us |            } /* schedule_timeout */
>  3354.481411 |   0)   sync-9362    | # 1894.576 us |          } /* wait_for_completion */
>  3354.481420 |   0)   sync-9362    | # 13762.41 us | __wait_on_bit();
>  3354.495187 |   0)   sync-9362    | # 13763.64 us |              } /* wait_on_page_bit */
>  3354.495196 |   0)   sync-9362    | # 16248.52 us | __wait_on_bit();
>  3354.511449 |   0)   sync-9362    | # 16249.50 us |              } /* wait_on_page_bit */
>  3354.511455 |   0)   sync-9362    | # 17580.20 us | __wait_on_bit();
>  3354.529041 |   0)   sync-9362    | # 17581.19 us |              } /* wait_on_page_bit */
>  3354.529047 |   0)   sync-9362    | # 16214.36 us | __wait_on_bit();
>  3354.545266 |   0)   sync-9362    | # 16215.31 us |              } /* wait_on_page_bit */
>  3354.545272 |   0)   sync-9362    | # 6439.709 us | __wait_on_bit();
>  3354.551715 |   0)   sync-9362    | # 6440.856 us |              } /* wait_on_page_bit */
>  3354.551723 |   0)   sync-9362    | # 70289.60 us |            } /* filemap_fdatawait_range */
>  3354.551723 |   0)   sync-9362    | # 70290.64 us |          } /* filemap_fdatawait */
>  3354.567133 |   0)   sync-9362    | # 87611.58 us |        } /* sync_inodes_sb */
>  3354.567133 |   0)   sync-9362    | # 87612.32 us |      } /* sync_inodes_one_sb */
>  3354.567251 |   0)   sync-9362    | # 87831.46 us |    } /* iterate_supers */
>  3354.568357 |   1)   sync-9362    | # 88971.71 us |  } /* sys_sync */
> 
> That is where the time is going in the "normal" case.

... this clearly shows sync is waiting on a dirty data being written
to disk. Write your trace files to something hosted on tmpfs (e.g.
/tmp) rather than copying them to a filesystem that requires IO
during the next sync call.


Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
