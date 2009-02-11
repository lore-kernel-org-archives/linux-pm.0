From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [rft]autosuspend for btusb
Date: Wed, 11 Feb 2009 16:52:21 +0000
Message-ID: <20090211165221.GB15838__37821.2574091323$1234371375$gmane$org@srcf.ucam.org>
References: <200808221520.19791.oliver@neukum.org>
	<200808221551.57225.oliver@neukum.org>
	<1219415470.7591.472.camel@violet.holtmann.net>
	<200808251243.47569.oliver@neukum.org>
	<72EBACB5-155E-4F42-9852-886AB6B10417@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <72EBACB5-155E-4F42-9852-886AB6B10417@holtmann.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org, Pavel Machek <pavel@suse.cz>, linux-pm@lists.linux-foundation.org, Stefan Seyfried <seife@suse.de>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 25, 2008 at 01:51:30PM +0200, Marcel Holtmann wrote:

> Can you break out the USB anchor extensions and make sure they get  
> merged into 2.6.28 in an early stage of the merge window. It really  
> wanna get all of this stuff into the next kernel release. Finally we  
> are getting somewhere with this driver and can kill the broken hci_usb.

The anchor extensions have hit mainline, but there doesn't seem to have 
been any progress on the btusb autosuspend front. Are there any plans 
for this?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
