From: Pavel Machek <pavel@suse.cz>
Subject: Re: [patch]full runtime power management for usbhid
Date: Thu, 28 Aug 2008 09:59:59 +0200
Message-ID: <20080828075959.GC15474__16864.6174752668$1219955816$gmane$org@elf.ucw.cz>
References: <200808261139.14410.oliver@neukum.org>
	<20080826142848.GB5496@ucw.cz>
	<200808261833.12355.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200808261833.12355.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: jkosina@suse.cz, linux-pm@lists.linux-foundation.org, dmitry.torokhov@gmail.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue 2008-08-26 18:33:11, Oliver Neukum wrote:
> Am Dienstag 26 August 2008 16:28:49 schrieb Pavel Machek:
> > Hmm... so numlock now costs ~3W... perhaps we should be defaulting to
> > numlock=off, again?
> 
> Estimate or measured quantity?

Measured on thinkpad x60 -- difference between no usb and usb active
(simulated by rmmod).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
