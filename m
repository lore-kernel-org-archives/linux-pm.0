From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC/RFT][PATCH -mm 8/8] PM: Rename hibernation_ops
	to platform_hibernation_operations
Date: Wed, 27 Jun 2007 17:19:56 +0200
Message-ID: <200706271719.57337.rjw__5481.16552313349$1182957190$gmane$org@sisk.pl>
References: <200706242239.05678.rjw@sisk.pl> <200706260052.28206.rjw@sisk.pl>
	<20070626085423.GC4594@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070626085423.GC4594@elf.ucw.cz>
Content-Disposition: inline
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
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 26 June 2007 10:54, Pavel Machek wrote:
> Hi!
> 
> > Rename 'struct hibernation_ops' to 'struct platform_hibernation_operations' in
> > analogy with 'struct platform_suspend_operations'.
> 
> Can I NAK it because it gets too long? platform_hibernation_ops /
> platform_suspend_ops is long but maybe acceptable, 'struct
> platform_hibernation_operations' is too long.

Okay, I can change both to platform_suspend_ops and platform_hibernation_ops
(should be mutually consistent IMO).

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
