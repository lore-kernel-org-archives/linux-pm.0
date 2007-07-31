From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/2] Introduce CONFIG_SUSPEND (updated)
Date: Tue, 31 Jul 2007 11:15:27 +0200
Message-ID: <200707311115.29057.rjw__43150.458604987$1185872838$gmane$org@sisk.pl>
References: <200707251238.50218.lenb@kernel.org>
	<200707292327.19884.rjw@sisk.pl>
	<200707310059.50329.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707310059.50329.lenb@kernel.org>
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
To: Len Brown <lenb@kernel.org>
Cc: david@lang.hm, Nigel Cunningham <nigel@nigel.suspend2.net>, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 31 July 2007 06:59, Len Brown wrote:
> On Sunday 29 July 2007 17:27, Rafael J. Wysocki wrote:
> > Still, there are many other files in which CONFIG_PM can be replaced
> > with CONFIG_PM_SLEEP or even with CONFIG_SUSPEND, but they can be updated in
> > the future.
> 
> There is #ifdef CONFIG_PM
> around all the .suspend and .resume methods.
> 
> Technically they are PM_DEVICE_STATES or something,
> that could really be under PM, and both SUSPEND and HIBERNATE
> would depend on PM_DEVICE_STATES, but it is also possible to have
> PM_DEVICE_STATES without SUSPEND and HIBERNATE.

Well, the people on linux-pm seem to agree that the .suspend() and .resume()
callbacks are not suitable for runtime power management, so having them
built without SUSPEND or HIBERNATION wouldn't be very useful. ;-)

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
