From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [RFC Disable suspend on a specific device] This	is	a
	little change in linux power scheme
Date: Wed, 08 Apr 2009 19:44:01 +0300
Message-ID: <1239209041.6228.217.camel@localhost>
References: <200904072257.23756.rjw@sisk.pl>
	<200904081013.25301.rjw@sisk.pl>	<49DC5F58.7070705@gandalf.sssup.it>
	<200904081034.56624.rjw@sisk.pl> <20090408114212.GK20122@sirena.org.uk>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090408114212.GK20122@sirena.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ext Mark Brown <broonie@sirena.org.uk>
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Wed, 2009-04-08 at 13:42 +0200, ext Mark Brown wrote:
> On Wed, Apr 08, 2009 at 10:34:56AM +0200, Rafael J. Wysocki wrote:
> 
> > I think this is a rather fundamental issue and it requires some more thought.
> 
> > What platform is your device based on, BTW?
> 
> FWIW this is an issue for a very large proportion of modern mobile phone
> platforms - when on a call they can often suspend the bulk of the system
> while leaving the audio path used for the call alive (normally some
> combination of the telephony modem, audio CODEC and bluetooth chipset)
> and wake up if the user presses a button or similar.

That might be the outcome, but it should be simply because those parts
which are not in use are idle and therefore can enter spontaneously into
a low power state.

-- 

Cheers, Igor

---

Igor Stoppa
Maemo Software - Nokia Devices R&D - Helsinki
