From: Dwight Schauer <dschauer@gmail.com>
Subject: Re: xHCI and suspend/resume
Date: Sat, 14 May 2011 16:28:09 -0500
Message-ID: <BANLkTik=qXDHj9Qv=c3S657SqEBAC9+1jw@mail.gmail.com>
References: <Pine.LNX.4.44L0.1105121733370.1917-100000@iolanthe.rowland.org>
	<201105132237.34988.rjw@sisk.pl>
	<BANLkTi=XzZsQeBR8-sm9gLjh_Tbyp5LWMg@mail.gmail.com>
	<201105142310.29314.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105142310.29314.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: dschauer@ti.com, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

2011/5/14 Rafael J. Wysocki <rjw@sisk.pl>:
> On Saturday, May 14, 2011, Dwight Schauer wrote:
>> On Fri, May 13, 2011 at 3:37 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > On Friday, May 13, 2011, Dwight Schauer wrote:
>> >> On Fri, May 13, 2011 at 3:04 PM, Rafael J. Wysocki <rjw@sisk.pl> wrot=
e:
>> >> > On Friday, May 13, 2011, Dwight Schauer wrote:
>> >> >> On Thu, May 12, 2011 at 5:29 PM, Rafael J. Wysocki <rjw@sisk.pl> w=
rote:
>> >> >> > On Thursday, May 12, 2011, Rafael J. Wysocki wrote:
>> >> >> >> On Thursday, May 12, 2011, Alan Stern wrote:

>> >> >> >> > For new readers: The problem is that an xHCI USB host control=
ler does
>> >> >> >> > not wake up a suspended system properly.
...
>> > So, clearly, you don't get any PCIe PME interrupts from root ports
>> > when the keyboard is plugged in. =A0Without those interrupts the runti=
me
>> > resume of xhci won't work.
>> >
>> > Please attach the output of "lspci -vv" with "auto" in the (suspended)=
 xhci's
>> > power/control file before and after you've plugged in the keyboard.
>> >
>> > Thanks,
>> > Rafael
>>
>> The lspci -vv before, after, and diff are attached.
>
> This means that the PME signaled by the xHCI doesn't cause the PMEStatus =
bit
> in its root port to be set, which is why the root port doesn't generate
> interrupts. =A0This seriously looks like a hardware bug and the only thing
> we could do to work around it would be to poll the xHCI for the PME status
> periodically (while suspended).
>
> Can you see if the feature works after booting with pcie_ports=3Dcompat in
> the kernel command line?
>
> Rafael
>

I'll try that on Monday (the pcie_ports=3Dcompat kernel option).

Well, I've got 2 different systems (one Intel and one AMD based, both
exhibit the same behavior). I have a few other systems I can try it on
as well on Monday.

Dwight
