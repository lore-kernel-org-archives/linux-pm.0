From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: Alternative Concept
Date: Tue, 20 Mar 2007 16:44:33 +0300
Message-ID: <45FFE541.60709@gmail.com>
References: <44ECFF94.3030506@gmail.com>	
	<200703182104.27555.david-b@pacbell.net>
	<45FF24C3.1000203@gmail.com>	
	<200703200107.17290.david-b@pacbell.net>
	<45FFAD39.1000302@gmail.com>	
	<1174386620.25744.23.camel@Dogbert.NOE.nokia.com>	
	<45FFD004.9030507@gmail.com>
	<1174394360.25744.45.camel@Dogbert.NOE.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174394360.25744.45.camel@Dogbert.NOE.nokia.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Igor Stoppa <igor.stoppa@nokia.com>
Cc: linux-pm@lists.osdl.org, Dominik Brodowski <linux@dominikbrodowski.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Igor Stoppa wrote:
>
>> So, in my thinking a devoted entity should exist to deal with such quest=
ions in =

>> regard to such shared pm resources. This entity is policy manager. Thus =
I see a =

>> need in an API for policy managers to be presented.
>
> Your policy manager becomes too invasive and even _mandatory_ because it
> becomes the only way to perform resource management.
>
> With a decentralised approach, instead, only people who _want_ to use
> the policy manager can include it, while otherwise they rely on the
> automatic handling.
>
Seems you both are considering  two opposite extremities. Why don't
consider
things as its nature? Every computer system  has  a subsystem =

delivering resources
to its elements, i.e subsystem delivering clocks - clock subsystem,
subsystem delivering
power - power subsystem. So you need to corresponding kernel  subsystems
to control that couple.
That is, there is a driver layer, there is clock/voltage subsytems and
eventually there is a policy
manager, i.e clock/volatge subsystem becomes a dealer for different
devices and also it becomes
a dealer for user space applications (i.e. policy managers).

As a thought, we already use an irq subsystem that provides resource -
interrupt, some ideas might be taken
there.
Thanks,
Dmitry
