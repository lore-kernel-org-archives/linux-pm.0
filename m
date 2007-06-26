From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC/RFT][PATCH -mm 1/4] PM: Introduce set_target
	method in pm_ops
Date: Tue, 26 Jun 2007 11:41:33 +0200
Message-ID: <200706261141.35071.rjw__14128.7321261645$1182850821$gmane$org@sisk.pl>
References: <200706242239.05678.rjw@sisk.pl> <200706242240.40476.rjw@sisk.pl>
	<1182806886.6644.4.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1182806886.6644.4.camel@johannes.berg>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 25 June 2007 23:28, Johannes Berg wrote:
> On Sun, 2007-06-24 at 22:40 +0200, Rafael J. Wysocki wrote:
> 
> > + * @set_target: Tell the platform which system sleep state is going to be
> > + *	entered.  The information passed to @set_target should be disregarded
> > + *	by the platform as soon as @finish() is executed and if	@prepare()
> > + *	fails.
> > + *	This callback is optional.  However, if it is implemented, the
> > + *	argument passed to @prepare(), @enter and @finish() must be ignored.
> 
> I don't understand the point in mandating that then the argument to
> enter() is to be ignored, why bother? It doesn't look as though we can
> possibly do anything with the semantics here that would mean the state
> set by set_target is different to the state passed to enter(), can we?

In principle we can't, but I think that it should be "either, or".  Either the
platform implements set_target() and uses the value provided by it, or it
uses the argument passed to the other functions.

Alternatively, I could write that the argument passed to .enter() etc. is
guaranteed to be the same as the one passed to .set_target(), but I didn't want
to say that. :-)

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
