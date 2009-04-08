From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: Re: [RFC Disable suspend on a specific device] This is a
 little	change in linux power scheme
Date: Wed, 08 Apr 2009 07:59:06 +0200
Message-ID: <49DC3D2A.1020405@gandalf.sssup.it>
References: <200904072257.23756.rjw@sisk.pl>	<Pine.LNX.4.44L0.0904071729210.307-100000@netrider.rowland.org>	<20090407213824.GM3278@elf.ucw.cz>
	<1239143110.7183.56.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1239143110.7183.56.camel@nigel-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

Nigel Cunningham wrote:
> Hi.
>
> On Tue, 2009-04-07 at 23:38 +0200, Pavel Machek wrote:
>> Well.... userspace should not have to decide this. If userspace tells
>> kernel not to suspend video card (on PC/ACPI), then we either honour
>> the request, or violate ACPI spec (and probably break suspend).
>
> What about the cases where the ACPI spec is irrelevant? (As I understand
> it, not all embedded boards use ACPI). Would this be a good approach in
> those cases? If so, perhaps the trick would be to make the functionality
> depend on !CONFIG_ACPI?
It can be an option, or just add only in embedded configuration where is 
not ACPI configured.
The dependences is allready provided by the kernel. The default is to 
have suspend enabled.
The user level access it's needed because the kernel does't exacly know 
when the device
must remain on/off during suspend. This api change can't cover any 
possible scenario but
introduce a flexbility scheame in suspend process. Avoid suspend in some 
device can be obtain
looking at dependece too? I don't know exacly if the acpi capapiblity 
can be seen throw the
link to a bus or a specific class, but we can limit it to the platform 
device instead
all device.

Michael
>
> Regards,
>
> Nigel
>
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>
