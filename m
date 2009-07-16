From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH 0/8] device async action mechanism
Date: Thu, 16 Jul 2009 06:45:16 -0700
Message-ID: <4A5F2EEC.8010508__26051.7483730384$1247751998$gmane$org@linux.intel.com>
References: <1247643512.26272.74.camel@rzhang-dt>
	<87ocrm6xeq.fsf@basil.nowhere.org>
	<1247710483.26272.170.camel@rzhang-dt>
	<20090716114020.GA11928@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090716114020.GA11928@khazad-dum.debian.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Henrique de Moraes Holschuh wrote:
> On Thu, 16 Jul 2009, Zhang Rui wrote:
>> the kernel device suspend time is reduced from 3.2s to 2.8s after
>> applying this patch set in my test box.
> 
> It will give even a bigger boot time saving on ThinkPads, where there is a
> Synaptics (or ALPS if you are unlucky) touchpad with the trackpoint behind
> it... it takes about 2s to init both devices here.  That's two seconds of
> boot time you can shove off if it is being initialized assyncronously :-)
> 

that's a different problem that I don't think this will solve; as long
as you keep the boot of the kernel wait for all async actions, you're going
to hit that wait. In Moblin we have a (bad) patch to not do the wait,
at some point we need to figure how to get a mainline-able patch....
