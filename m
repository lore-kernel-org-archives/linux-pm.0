From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] CPU C-state breakage with PM Qos change
Date: Mon, 6 Feb 2012 17:42:00 +0100
Message-ID: <CAORVsuW7mBCZdGqScX5jjaYDhijZH_H7vDKkJ4v6WWHn9rUsGw@mail.gmail.com>
References: <1328227065-22045-1-git-send-email-venki@google.com>
	<CAN5iSWo-n7OER4i1tPoeGBhY_RY-nX=7n4B3mFv1f0JK074bhQ@mail.gmail.com>
	<20120205035057.GA4948@gs62> <201202051204.38717.rjw@sisk.pl>
	<CAORVsuVCYp+Fmfaje-UDnv1=x0PqApML6Jb-Z6EG0425SuREMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAORVsuVCYp+Fmfaje-UDnv1=x0PqApML6Jb-Z6EG0425SuREMg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, Venkatesh Pallipadi <venki@google.com>, markgross@thegnar.org, linux-kernel@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, "Pihet-XID, Jean" <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

Rafael,

On Mon, Feb 6, 2012 at 11:18 AM, Jean Pihet <jean.pihet@newoldbits.com> wro=
te:
> Hi Rafael, Mark,
>
> On Sun, Feb 5, 2012 at 12:04 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
...

>> In kernel/power/Makefile:
>>
>> obj-$(CONFIG_PM) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D main.o qos.o
>>
>> I guess that explains things. :-)
> Initially I thought we should have a way of disabling the feature on
> some (minimal) kernels and so thought CONFIG_PM was the option to use.
>
>> It's quite easy to make qos.o be independent of CONFIG_PM, in which case=
 the
>> code added by Venki can be removed, so patches welcome (for 3.4, though).
> I am working on it, more to come soon.

I have a couple of patches ready, to be applied on 3.3-rc1 (so without
Venki's patch applied).
The first one is on PM QoS, the second one on per-device PM QoS. Is
the latter needed?

Please let me know and I will send them asap.

Regards,
Jean

>>
>> Thanks,
>> Rafael
