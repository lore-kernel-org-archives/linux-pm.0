From: Jiri Kosina <jikos@kernel.org>
Subject: [PATCH 0/3] PM, vfs: use filesystem freezing instead of kthread
 freezer
Date: Fri, 30 Oct 2015 14:47:03 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1510301424360.17538@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@ZenIV.linux.org.uk>, Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This series is a followup to my proposal I brought up on Kernel Summit in 
Seoul. Noone seemed to had any principal objections, so let's have wider 
audience look into it.

In a nuthsell: freezing of kernel threads is horrible interface with 
unclear semantics and guarantees, and I am surprised it ever worked 
properly. Plus there are a lot of places that simply use it in a 
completely wrong way (which is not suprising, given the lack of defined 
semantics and requirements).

I've tested this over a series of suspend/resume cycles on several 
machines with at least ext4, btrfs and xfs, and it survived the testing 
without any harm.

Patch 1/3 	implements the actual change, and has a more detailed 
		explanation on "why?" and "how?" questions in the changelog

Patch 2/3	nukes all (hopefully) the calls to freezer from kthreads 
		in Linus' tree (as of 858e904bd71)

Patch 3/3	introduces WARN_ON() if anyone is trying to make use of 
		this again

Open questions / discussion points:

- is the way I am traversing list of superblocks backwards enough to 
  guarantee correct ordering? Especially: does this work as intended for 
  FUSE?

- should freezable workqueues be dealt with the same way? I haven't even 
  started to look into them in a serious way, but it seems like the 
  drivers that are making use of them would actually like to use proper
  PM callbacks instead

-- 
Jiri Kosina
SUSE Labs
