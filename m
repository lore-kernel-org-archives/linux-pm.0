From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Fri, 13 Feb 2009 17:05:18 +0000
Message-ID: <20090213170518.GA29902@srcf.ucam.org>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<20090213142409.GA29487@bulgaria.corp.google.com>
	<20090213143730.GA27365@srcf.ucam.org>
	<200902131746.42914.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902131746.42914.u.luckas@road.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Uli Luckas <u.luckas@road.de>
Cc: Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org, "ncunningham@crca.org.au" <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 13, 2009 at 05:46:42PM +0100, Uli Luckas wrote:

> That's racy. By the time the daemon notices that a process crashed, the kernel 
> might already have triggered suspend. userspace might then be frozen before 
> it can accuire the 'process restarting' lock.
> I also wonder, if it is immanently racy to use userspcae communication 
> (client/daemon) for suspend locks. What if the daemon is already frozen when 
> a client sends a lock request request? 

The daemon holds the lock in the first place. There's no race. As for 
issues with the freezer, I think my position on that is fairly well 
known...

-- 
Matthew Garrett | mjg59@srcf.ucam.org
