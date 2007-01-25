From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: [PATCH] Fix swsusp-change-code-order-in-diskc.patch
Date: Thu, 25 Jan 2007 15:51:08 +0300
Message-ID: <45B8A7BC.8060100@linux.intel.com>
References: <45B8A456.2010301@linux.intel.com>
	<20070125124325.GH23343@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070125124325.GH23343@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org, "Brown,
	Len" <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> Hi!
>
>   =

>> Recent patch from Rafael changed the order of platform_prepare() and
>> swsusp_read(). platform_prepare() should happen before swsusp_read()
>> in order to get nice LED blinking during load of the image and time for
>> GPE activity to settle down.
>>     =

>
> Well, looks acceptable to me.
>
> But if GPEs need some time to settle down, that should be done
> explicitely, and with _big_ comment? What if your disk is too fast?
>
> Also, same problem is likely present in uswsusp (and harder to fix
> there). Is this really required?
> 									Pavel
>   =

ACPI interrupt gets disabled if the GPE activity is not disabled before =

switching to loaded image
on some Acer machines. In most cases disabling them just before =

sw_switch() is enough, but it's better to
be on a safe side. And don't forget about blinking LED :)

Regards,
    Alex.
