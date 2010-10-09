From: Len Brown <lenb@kernel.org>
Subject: [git pull request] idle patch for Linux-2.6.36-rc7
Date: Fri, 08 Oct 2010 22:51:33 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010082247110.3961@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Power Management List <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi Linus,

please pull from: 

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-idle-2.6.git idle-release

This fixes a 'regression' seen by those switching to
2.6.35's new intel_idle driver from 2.6.34's acpi_idle driver
if they are running on some Atom Z-series.

I had disabled ATM-C6 in Atom pending public documentation.

This will update the files shown below.

thanks!

--
Len Brown
Intel Open Source Technology Center


ps. individual patches are available on linux-pm@lists.linux-foundation.org
and a consolidated plain patch is available here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/idle/patches/2.6.36/idle-release-2.6.36-rc7.diff.gz

 drivers/idle/intel_idle.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

through these commits:

Len Brown (1):
      intel_idle: enable Atom C6

with this log:

commit c7d96d8ee49e5020e4c5e73687c068dbdca2a4e8
Author: Len Brown <len.brown@intel.com>
Date:   Tue Oct 5 13:43:14 2010 -0400

    intel_idle: enable Atom C6
    
    ATM-C6 was commented out, pending public documentation.
    
    https://bugzilla.kernel.org/show_bug.cgi?id=19762
    
    Tested-by: Dennis Jansen <Dennis.Jansen@...>
    Signed-off-by: Len Brown <len.brown@intel.com>
