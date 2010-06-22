From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 1/2] ACPI: Save/Restore NVS area on
 suspend/resume too
Date: Tue, 22 Jun 2010 18:19:52 +0300
Message-ID: <1277219992.4867.2.camel__3097.5577574738$1277220071$gmane$org@maxim-laptop>
References: <1275077971.20606.20.camel@maxim-laptop>
	<1275078137-21139-1-git-send-email-maximlevitsky@gmail.com>
	<20100621155313.GA1447@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100621155313.GA1447@ucw.cz>
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
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg59-kernel@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2010-06-21 at 17:53 +0200, Pavel Machek wrote: 
> On Fri 2010-05-28 23:22:16, Maxim Levitsky wrote:
> > Although this is clear violation of ACPI spec. the other OS does that...
> >
> 
> So you are adding bugs... what about having them optional, probably
> quirk-driven?

Because like someone (Linus?) said, specs are just paper, nothing more.

The real spec is what windows does.
This is sad but true.


Best regards,
Maxim Levitsky
