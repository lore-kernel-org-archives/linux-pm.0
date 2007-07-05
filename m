From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to
	RAM pathway
Date: Thu, 5 Jul 2007 17:15:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707051713440.2753-100000__15687.1843770661$1183670490$gmane$org@iolanthe.rowland.org>
References: <E1I6YXX-0001yE-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1I6YXX-0001yE-00@dorka.pomaz.szeredi.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mjg59@srcf.ucam.org, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thu, 5 Jul 2007, Miklos Szeredi wrote:

> I fear, that your efforts to "save" the freezer are in vain.  It is
> already moderately hackish with that PF_FREEZER_SKIP and the kernel
> dotted randomly with try_to_freeze() calls, but adding bandaids to try
> to order freezing userspace processes in the right order would just
> make it a horrible mess.

I agree that bandaids won't work.  What's needed is something more 
radical.  Things like FUSE must be written so that the kernel parts 
_can_ freeze even while they are waiting for a response from a user 
thread.

Alan Stern
