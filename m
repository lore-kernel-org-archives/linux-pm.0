From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: SCSI power management for AHCI
Date: Wed, 16 Jan 2008 10:21:35 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0801161020190.4431-100000__35843.1243141696$1200496983$gmane$org@iolanthe.rowland.org>
References: <20080115201114.GA7219@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080115201114.GA7219@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, linux-scsi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 15 Jan 2008, Pavel Machek wrote:

> Hi!
> 
> This is my first attempt at ahci autosuspend. It is _very_ hacky at
> this moment, I'll seriously need to clean it up. But it seems to work
> here.

How does this interact with Link Power Management?  Should there be 
a stronger connection between the two?

Alan Stern
