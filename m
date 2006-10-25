From: Dave Jones <davej@redhat.com>
Subject: Re: [RFC][PATCH -mm] Make swsusp work on i386 with PAE
Date: Wed, 25 Oct 2006 04:05:08 -0400
Message-ID: <20061025080508.GB19551@redhat.com>
References: <200610221548.48204.rjw@sisk.pl> <20061023145033.GB31273@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1423035AbWJYIFm@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20061023145033.GB31273@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 23, 2006 at 04:50:33PM +0200, Pavel Machek wrote:
 > Hi!
 > 
 > > The purpose of the appended patch is to make swsusp work on i386 with PAE,
 > > but it should also allow i386 systems without PSE to use swsusp.
 > > 
 > > The patch creates temporary page tables located in resume-safe page frames
 > > during the resume and uses them for restoring the suspend image (the same
 > > approach is used on x86-64).
 > > 
 > > It has been tested on an i386 system with PAE and survived several
 > > suspend-resume cycles in a row, but I have no systems without PSE, so that
 > > requires some testing.
 > 
 > Thanks, looks okay to me. I guess Andi Kleen would be right person to
 > review it in detail?

I gave it a quick skim, and saw nothing obviously broken fwiw.
Thanks for doing this work, it's definitly something that's needed.

	Dave

-- 
http://www.codemonkey.org.uk
