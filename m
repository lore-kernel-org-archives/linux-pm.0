From: Igor Stoppa <igor.stoppa@nokia.com>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Sat, 31 Jan 2009 20:54:35 +0200
Message-ID: <1233428075.4566.3.camel@localhost>
References: <Pine.LNX.4.44L0.0901311033590.6305-100000@netrider.rowland.org>
	<200901311939.30837.rjw@sisk.pl>
Reply-To: igor.stoppa@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901311939.30837.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "ext Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Brian Swetland <swetland@google.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

Hi,
On Sat, 2009-01-31 at 19:39 +0100, ext Rafael J. Wysocki wrote:

> Well, I think that sleep states are not really useful in cell phones.
> Useful
> is the ability to put all devices into low power states separately and
> as
> needed (eg. after a period of inactivity).  IOW, the system as a whole
> is
> in the working state, but some parts of the hardware may be in low
> power states
> (even all of the I/O devices may be in low power states).  That may
> very well
> look "asleep" from the user point of view, but it is not a sleep
> state.

yup

it's very depressing that several years after we released the Nokia 770,
in the far 2005, people are still talking about these basic concepts.

And while it can be somehow excused for what concerns the x86 world of
laptops, it's even more depressing that such discussion surfaces in
relation to Android.

-- 

Cheers, Igor

---

Igor Stoppa
Maemo Software - Nokia Devices R&D - Helsinki
