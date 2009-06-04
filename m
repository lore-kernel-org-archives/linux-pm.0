From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 00/04][RFC] PM: Runtime platform device PM
Date: Thu, 4 Jun 2009 19:03:50 +0900
Message-ID: <aec7e5c30906040303v172708bela84bfcb508d4abea__42037.0790911422$1244109889$gmane$org@mail.gmail.com>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
	<877i01p2t8.fsf@deeprootsystems.com>
	<aec7e5c30905290217s651e5785s2ceaebbe1856d120@mail.gmail.com>
	<20090602213722.GA1972@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090602213722.GA1972@ucw.cz>
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
Cc: paul@pwsan.com, gregkh@suse.de, linux-pm@lists.linux-foundation.org, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Pavel!

On Wed, Jun 3, 2009 at 6:37 AM, Pavel Machek <pavel@ucw.cz> wrote:
>> > In the process of discussing a similar interface for OMAP, we dicussed
>> > that having 3 states would be more useful. =A0Specifically, and
>> > _enable(), _idle() and _disable() hook. =A0The _enable() and _idle()
>> > hooks being exactly what you proposed above, but with the addition of
>> > a _disable() hook which says not only can the device go idle, but that
>> > the driver is really finished with the device. =A0In this case, more
>> > aggresive PM measures could be taken, such as turning of regulators
>> > that may have long latencies that may not be appropriate to turn off
>> > in idle.
>>
>> Hm.. I wonder when the driver is really finished with the device
>> though. Only when the module is unloaded? If so then we could deal
>> with the hard disable using platform bus notifiers (like in [04/04]).
>
> I'd guess that they call disable() when /dev node is closed... and
> idle() when device is opened but inactive.

But the time from close() to next open() is work load dependent. So
the difference between _disable() and _idle() is pretty fuzzy in my
opinion. I'm trying to think of a case where hard _disable() is
needed, but nothing comes to mind.

In my mind a single disable()/idle() function together with latency
information is enough. It covers the entire range from _idle() to hard
_disable().

/ magnus
