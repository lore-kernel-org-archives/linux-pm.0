From: Matt Helsley <matthltc@us.ibm.com>
Subject: [RFC PATCH 0/4] Container Freezer: Reuse Suspend Freezer
Date: Wed, 02 Apr 2008 19:08:08 -0700
Message-ID: <34226.9571534873$1207234905@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: linux-pm@lists.linux-foundation.org, Cedric Le Goater <clg@fr.ibm.com>
List-Id: linux-pm@vger.kernel.org

This patchset is a prototype using the container infrastructure and
the swsusp freezer to freeze a group of tasks. I've merely taken Cedric's
patches, forward-ported them to 2.6.25-rc8-mm1 and done a small amount of
testing.

2 files are defined by the freezer subsystem in the container
filesystem :

   * "freezer.freeze"

     writing 1 will freeze all tasks and 0 unfreeze
     reading will return the status of the freezer
 
   * "freezer.kill"

     writing <n> will send signal number <n> to all tasks

* Usage :

   # mkdir /containers/freezer
   # mount -t container -ofreezer freezer  /containers/freezer
   # mkdir /containers/freezer/0
   # echo $some_pid > /containers/freezer/0/tasks

to get status of the freezer subsystem :

   # cat /containers/freezer/0/freezer.freeze
   RUNNING

to freeze all tasks in the container :

   # echo 1 > /containers/freezer/0/freezer.freeze
   # cat /containers/freezer/0/freezer.freeze
   FREEZING
   # cat /containers/freezer/0/freezer.freeze
   FROZEN

to unfreeze all tasks in the container :

   # echo 1 > /containers/freezer/0/freezer.freeze
   # cat /containers/freezer/0/freezer.freeze
   RUNNING

to kill all tasks in the container :

   # echo 9 > /containers/freezer/0/freezer.kill

* Caveats: 

  - the FROZEN status is calculated and changed when the container
    file "freezer.freeze" is read.
  - frozen containers will be unfrozen when a system is resumed after 
    a suspend. This is addressed by the last patch.

* Series

  Applies to 2.6.25-rc8-mm1

  The first patches make the freezer available to all architectures
  before implementing the freezer subsystem.

[PATCH 1/4] Add TIF_FREEZE flag to all architectures
[PATCH 2/4] Make refrigerator always available
[PATCH 3/4] Implement freezer cgroup subsystem
[PATCH 4/4] Skip frozen cgroups during power management resume

  Each patch compiles, boots, and survives basic LTP containers and controllers 
  	tests.
  
Comments are welcome.

Cheers,
	-Matt Helsley

-- 
