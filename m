From: Tino Keitel <tino.keitel@gmx.de>
Subject: Re: autosuspend for SCSI devices
Date: Mon, 25 Aug 2008 21:47:03 +0200
Message-ID: <20080825194702.GA31007__7070.37437609888$1219695678$gmane$org@dose.home.local>
References: <20080822105626.GA9475@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080822105626.GA9475@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 22, 2008 at 12:56:27 +0200, Pavel Machek wrote:
> From: Alan Stern <stern@rowland.harvard.edu>
> 
> Add support for autosuspend/autoresume of the SCSI devices. Lowlevel
> driver can use it to spin the disk down... and it is neccessary step
> for powering down the controllers.
> 
> Spinning down the disk is useful - saves ~0.5W here, and it is last
> major thing we can do to save power on some small machines like
> Kohjinsha subnotebooks.

Is there a difference regarding power saving to the already existing
ways to spin down a disk, like noflushd? In a previous patch you
mentioned that this can be used to disable the SATA port so save even
more power. However, this part seems to be missing in this patch,
right?

Regards,
Tino
