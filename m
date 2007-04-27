From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [RFC/PATCH 1/2] swsusp: preserve boot-time printk
	output after resume
Date: Fri, 27 Apr 2007 10:36:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0704271036070.3430-100000@iolanthe.rowland.org>
References: <84144f020704270710o13cbaadep909826b903ad564c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <84144f020704270710o13cbaadep909826b903ad564c@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: nigel@nigel.suspend2.net, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Fri, 27 Apr 2007, Pekka Enberg wrote:

> On 4/27/07, Alan Stern <stern@rowland.harvard.edu> wrote:
> > Consider this: Add a debugfs file containing a binary value.  If the value
> > is on then preserve the boot dmesg buffer.  If the value is off, don't
> > preserve it -- overwrite the buffer pointers with values saved in the
> > image.
> 
> But isn't it impractical to change a debugfs file upon kernel startup
> before we hit resume? Or do you mean we always make a copy of the
> dmesg buffer before resume starts and afterwards replace the new one
> if the debug value is set?

Yes, that's what I meant.  It would make changing the setting a lot easier 
during testing.

Alan Stern
