From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 08:43:04 +0200
Message-ID: <200804140843.06088.oliver__49397.2614211545$1208155611$gmane$org@neukum.org>
References: <200804040111.15255.rjw@sisk.pl> <200804140309.22057.rjw@sisk.pl>
	<1208143380.6958.105.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1208143380.6958.105.camel@pasglop>
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
To: benh@kernel.crashing.org
Cc: Nigel Cunningham <ncunningham@crca.org.au>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Am Montag, 14. April 2008 05:23:00 schrieb Benjamin Herrenschmidt:
> 
> > To avoid breaking things (from the functional point of view) unnecessarily.
> > 
> > In short, I don't really see the difference between moving ->prepare() before
> > the freezer and droppig the freezer, which I'm not going to do right now.
> 
> I believe the use of prepare for things like request_firmware etc... is
> worth the effort of fixing the known breakage of not having the freezer
> while preventing insertion of new devices (mostly USB). In fact, it
> won't be such a big issue as the core should/will return an error from
> attempting to add the device in that case.

Which is the problem. Suspension is supposed to be transparent.
We cannot start returning error codes for operations which never
failed in practice (eg. switching configurations in USB), just because
the system is about to be suspended.

If you want to request firmware in a PM callback, which makes a certain
sense, as we should move to a comprehensive API, if we change the API
at all, we need a model with 3 callbacks.

	Regards
		Oliver
