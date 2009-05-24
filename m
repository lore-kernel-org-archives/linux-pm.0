From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] why do we need run disk sync before	entering?S3
Date: Sun, 24 May 2009 23:14:33 +0200
Message-ID: <20090524211433.GB1693__45898.8365521238$1243199802$gmane$org@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0905131000360.3004-100000@iolanthe.rowland.org>
	<200905231105.03828.oliver@neukum.org>
	<20090523094518.GB8782@elf.ucw.cz>
	<200905242302.55640.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200905242302.55640.oliver@neukum.org>
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
Cc: linux-acpi <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun 2009-05-24 23:02:55, Oliver Neukum wrote:
> Am Samstag, 23. Mai 2009 11:45:18 schrieb Pavel Machek:
> > suspend.sf.net, program s2both :-).
> 
> Cool. What happens if you crash after unfreezing user space but before you
> declare the image invalid?

I'd have to check the code to make sure, but it should first kill the
image and then unfreeze :-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
