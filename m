From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [RFC Disable suspend on a specific device] This	is	a
	little change in linux power scheme
Date: Wed, 08 Apr 2009 19:45:56 +0300
Message-ID: <1239209157.6228.219.camel@localhost>
References: <Pine.LNX.4.44L0.0904071729210.307-100000@netrider.rowland.org>
	<200904072340.53638.rjw@sisk.pl> <20090408115330.GL20122@sirena.org.uk>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090408115330.GL20122@sirena.org.uk>
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
Cc: "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2009-04-08 at 13:53 +0200, ext Mark Brown wrote:
> On Tue, Apr 07, 2009 at 11:40:53PM +0200, Rafael J. Wysocki wrote:
> 
> > IMO, there is a danger that suspend will break or even the machine will crash
> > if this is used for a wrong device.  I don't think it's generally safe to add
> > switches like this on the core level, because the core doesn't really know
> > which drivers are prepared for it.
> 
> OTOH it would be good to have a standard way of exposing this behaviour
> to user space when it can be supported so that applications have some
> degree of abstraction when working with these systems and drivers don't
> have to keep on cooking up their own methods of exposing it.

Don't rely on this method and instead implement automatic power saving
when entering runtime idle.

-- 

Cheers, Igor

---

Igor Stoppa
Maemo Software - Nokia Devices R&D - Helsinki
