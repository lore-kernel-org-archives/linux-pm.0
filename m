From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: Regression: active uvcvideo breaks over suspend
Date: Wed, 15 Apr 2009 11:09:22 +0100
Message-ID: <49E5B252.4030104__13308.6609458134$1239790446$gmane$org@tuffmail.co.uk>
References: <49E5B2F3.4080502@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <49E5B2F3.4080502@tuffmail.co.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: USB list <linux-usb@vger.kernel.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

[removed from members-only mailing list]

Alan Jenkins wrote:
> I found this in v2.6.30-rc2.  I haven't tested beyond that.  I'm sure
> it didn't happen in 2.6.29.
>
> If I run "xawtv" and then suspend, it stops working on resume; the
> xawtv display goes black and the camera LED stays off.  When I close
> xawtv, the LED blinks on then off again.  If I then try to run xawtv
> again, it works fine.
>
> In dmesg (after resume) I see
>
> [  562.884298] usb 1-8: type resume
> [  562.990014] usb 1-8: reset high speed USB device using ehci_hcd and
> address 3
> [  563.665921] restoring control 00000000-0000-0000-0000-000000000101/0/2
> [  563.665935] restoring control 00000000-0000-0000-0000-000000000101/1/3
> [  563.665948] restoring control 00000000-0000-0000-0000-000000000101/3/7
> [  563.666412] uvcvideo 1-8:1.1: reset_resume error -12
>
> Thanks in advance
> Alan
