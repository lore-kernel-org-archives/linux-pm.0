From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Fri, 19 Jun 2015 02:34:37 -0400
Message-ID: <CAJvTdKm15=+S4Y0mR+rzm8FOi2sfwGSqz9yiSh+GNcgMf85NxQ@mail.gmail.com>
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
	<20150619043147.GA16870@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34737 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbbFSGej (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 02:34:39 -0400
In-Reply-To: <20150619043147.GA16870@dastard>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: NeilBrown <neilb@suse.de>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "Rafael J. Wysocki" <rafael@kernel.org>, Ming Lei <tom.leiming@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

> Can you repeat this test on your system, so that we can determine if
> the 5ms ""sync time" is actually just the overhead of inode cache
> traversal? If that is the case, the speed of sync on a clean
> filesystem is already a solved problem - the patchset should be
> merged in the 4.2 cycle....

Yes, drop_caches does seem to help repeated sync on this system:
Exactly what patch series does this?  I'm running ext4 (the default,
not btrfs)

[lenb@d975xbx ~]$ for i in `seq 0 1 10`; do time sleep 0 ; done

real    0m0.002s
user    0m0.000s
sys     0m0.001s

real    0m0.001s
user    0m0.000s
sys     0m0.001s

real    0m0.001s
user    0m0.001s
sys     0m0.001s

real    0m0.001s
user    0m0.000s
sys     0m0.001s

real    0m0.001s
user    0m0.001s
sys     0m0.000s

real    0m0.001s
user    0m0.001s
sys     0m0.000s

real    0m0.001s
user    0m0.001s
sys     0m0.000s

real    0m0.001s
user    0m0.000s
sys     0m0.001s

real    0m0.001s
user    0m0.001s
sys     0m0.000s

real    0m0.001s
user    0m0.001s
sys     0m0.000s

real    0m0.001s
user    0m0.000s
sys     0m0.001s
[lenb@d975xbx ~]$ for i in `seq 0 1 10`; do time sync ; done

real    0m0.004s
user    0m0.000s
sys     0m0.003s

real    0m0.002s
user    0m0.000s
sys     0m0.002s

real    0m0.002s
user    0m0.000s
sys     0m0.002s

real    0m0.002s
user    0m0.000s
sys     0m0.002s

real    0m0.002s
user    0m0.000s
sys     0m0.002s

real    0m0.002s
user    0m0.000s
sys     0m0.002s

real    0m0.002s
user    0m0.000s
sys     0m0.003s

real    0m0.002s
user    0m0.000s
sys     0m0.002s

real    0m0.002s
user    0m0.000s
sys     0m0.002s

real    0m0.002s
user    0m0.000s
sys     0m0.002s

real    0m0.002s
user    0m0.000s
sys     0m0.002s
[lenb@d975xbx ~]$ sudo grep ext4_inode /proc/slabinfo
ext4_inode_cache    3536   3536   1008   16    4 : tunables    0    0
  0 : slabdata    221    221      0
[lenb@d975xbx ~]$ sudo sh -c "echo 3 > /proc/sys/vm/drop_caches "
[lenb@d975xbx ~]$ sudo grep ext4_inode /proc/slabinfo
ext4_inode_cache     553   1680   1008   16    4 : tunables    0    0
  0 : slabdata    105    105      0
[lenb@d975xbx ~]$ for i in `seq 0 1 10`; do time sync ; done

real    0m0.002s
user    0m0.000s
sys     0m0.001s

real    0m0.002s
user    0m0.000s
sys     0m0.002s

real    0m0.001s
user    0m0.000s
sys     0m0.001s

real    0m0.001s
user    0m0.000s
sys     0m0.001s

real    0m0.001s
user    0m0.000s
sys     0m0.001s

real    0m0.001s
user    0m0.000s
sys     0m0.001s

real    0m0.001s
user    0m0.000s
sys     0m0.001s

real    0m0.001s
user    0m0.000s
sys     0m0.001s

real    0m0.001s
user    0m0.000s
sys     0m0.001s

real    0m0.001s
user    0m0.000s
sys     0m0.001s

real    0m0.001s
user    0m0.000s
sys     0m0.002s


>> While they were all to slow, none of them were
>>  O(500ms), so yes, there
>> does seem to be some state change
>> that causes the 2nd sync after a resume to be especially slow.
>>
>> Unfortunately, I've not got an ftrace on the 500ms flavor yet.
>
> This is the problem we really need to reproduce and track down.

Putting a function trace on sys_sync and executing sync manually,
I was able to see it take 100ms,
though function trace itself could be contributing to that...

[lenb@d975xbx ~]$ grep \# trace.20150619_013702
# tracer: function_graph
#
#     TIME        CPU  DURATION                  FUNCTION CALLS
#      |          |     |   |                     |   |   |   |
  374.665063 |   0) # 2229.612 us |                } /* __schedule */
  374.665064 |   0) # 2230.571 us |              } /* schedule */
  374.665064 |   0) # 2231.494 us |            } /* schedule_timeout */
  374.665065 |   0) # 2235.937 us |          } /* wait_for_completion */
  374.745616 |   0) # 80518.73 us |                          } /* __schedule */
  374.745616 |   0) # 80519.47 us |                        } /* schedule */
  374.745617 |   0) # 80520.28 us |                      } /*
schedule_timeout */
  374.745621 |   0) # 80526.38 us |                    } /*
io_schedule_timeout */
  374.745621 |   0) # 80527.23 us |                  } /* bit_wait_io */
  374.745622 |   0) # 80531.04 us |                } /* __wait_on_bit */
  374.745623 |   0) # 80531.95 us |              } /* wait_on_page_bit */
  374.745644 |   0) # 80555.58 us |            } /* filemap_fdatawait_range */
  374.745644 |   0) # 80556.36 us |          } /* filemap_fdatawait */
  374.748029 |   0) # 1300.848 us |                          } /* __schedule */
  374.748029 |   0) # 1301.376 us |                        } /* schedule */
  374.748029 |   0) # 1301.923 us |                      } /*
schedule_timeout */
  374.748032 |   0) # 1306.133 us |                    } /*
io_schedule_timeout */
  374.748032 |   0) # 1306.651 us |                  } /* bit_wait_io */
  374.748033 |   0) # 1309.298 us |                } /* __wait_on_bit */
  374.748033 |   0) # 1309.838 us |              } /* wait_on_page_bit */
  374.750502 |   0) # 1099.379 us |                          } /* __schedule */
  374.750503 |   0) # 1100.102 us |                        } /* schedule */
  374.750503 |   0) # 1100.882 us |                      } /*
schedule_timeout */
  374.750509 |   0) # 1108.399 us |                    } /*
io_schedule_timeout */
  374.750510 |   0) # 1109.160 us |                  } /* bit_wait_io */
  374.750511 |   0) # 1112.541 us |                } /* __wait_on_bit */
  374.750512 |   0) # 1113.310 us |              } /* wait_on_page_bit */
  374.752063 |   0) # 5827.910 us |            } /* filemap_fdatawait_range */
  374.752063 |   0) # 5828.517 us |          } /* filemap_fdatawait */
  374.764753 |   0) # 101948.3 us |        } /* sync_inodes_sb */
  374.764754 |   0) # 101949.1 us |      } /* sync_inodes_one_sb */
  374.764903 |   0) # 102198.2 us |    } /* iterate_supers */
  374.767693 |   0) # 1094.872 us |                  } /* blk_flush_plug_list */
  374.767693 |   0) # 1095.405 us |                } /* blk_finish_plug */
  374.767694 |   0) # 1780.430 us |              } /* generic_writepages */
  374.767694 |   0) # 1781.172 us |            } /* do_writepages */
  374.767694 |   0) # 1784.820 us |          } /* __filemap_fdatawrite_range */
  374.767695 |   0) # 1785.551 us |        } /* filemap_fdatawrite */
  374.767695 |   0) # 1786.357 us |      } /* fdatawrite_one_bdev */
  374.767698 |   0) # 1857.427 us |    } /* iterate_bdevs */
  374.767818 |   0) # 105179.2 us |  } /* sys_sync */

running analyze_suspend.py after the slab tweak above didn't change much.
in one run sync was 20ms (out of a total suspend time of 60ms).

Curiously, in another run, sync ran at 15ms, but sd suspend exploded to 300ms.
I've seen that in some other results.  Sometimes sync if fast, but sd
then more than makes up for it by being slow:-(

FYI,
I ran analyze_suspend.py -x2
from current directory /tmp, which is mounted on tmpfs,
but still found the 2nd sync was very slow -- 200ms
vs 6 - 20 ms for the sync preceding the 1st suspend.

thanks
Len Brown, Intel Open Source Technology Center
