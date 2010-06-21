From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] ACPI: Save/Restore NVS area on
 suspend/resume too
Date: Mon, 21 Jun 2010 17:53:15 +0200
Message-ID: <20100621155313.GA1447__32958.0565136441$1277205024$gmane$org@ucw.cz>
References: <1275077971.20606.20.camel@maxim-laptop>
	<1275078137-21139-1-git-send-email-maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1275078137-21139-1-git-send-email-maximlevitsky@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59-kernel@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org

On Fri 2010-05-28 23:22:16, Maxim Levitsky wrote:
> Although this is clear violation of ACPI spec. the other OS does that...
>

So you are adding bugs... what about having them optional, probably
quirk-driven?
									Pavel
 
> Since other OS restores this region some BIOSes rely on this,
> and won't resume the system second time
> 
> see: https://bugzilla.kernel.org/show_bug.cgi?id=13931

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
