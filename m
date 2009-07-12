From: "Mahalingam, Nithish" <nithish.mahalingam@intel.com>
Subject: Re: [RFC][PATCH] PM: Introduce core framework for
 run-time PM of I/O devices (rev. 8)
Date: Sun, 12 Jul 2009 07:35:07 +0530
Message-ID: <175E0F9A9EFCEA46A65F5552BB057298BB5F43F0__42084.6052970321$1247364394$gmane$org@bgsmsx502.gar.corp.intel.com>
References: <aec7e5c30907081952t4b88f1ccjeec6ab11b1d913b8@mail.gmail.com>
	<aec7e5c30907090831y180b0972o6dcb961dd292a3c0@mail.gmail.com>
	<175E0F9A9EFCEA46A65F5552BB057298BB5F3EA2@bgsmsx502.gar.corp.intel.com>
	<200907111308.44388.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200907111308.44388.rjw@sisk.pl>
Content-Language: en-US
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
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Arjan@smtp1.linux-foundation.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

>Hi,
>
>> I am newbee to this mailing list. Please excuse me if I am talking nonsense here.
>> 
>> 
>> 
>> On Thu, Jul 9, 2009 at 10:48 PM, Alan Stern<stern@rowland.harvard.edu> wrote:
>>>> On Thu, 9 Jul 2009, Magnus Damm wrote:
>>>>
>>>> Clocks should be stopped as soon as possible without any delay. The
>>>> clock stopping is very cheap performance wise. Also, the clock
>>>> stopping is done on bus level without invoking any driver callbacks.
>>>>> Delaying the clock stopping does not make any sense to me.
>>>>
>>>> In that case the device driver or bus subsystem should manage the
>>>> device's clock directly.  There's no need to tie it in with the runtime
>>>> PM framework.  Simply start the clock before each I/O operation and
>>>> stop it afterward.
>> 
>>> It's not that easy. The clock needs to be enabled to let the hardware
>>> device perform device specific stuff. For instance, the clock for the
>>> LCD controller needs to be on to redraw the screen. When the driver
>>> knows that it's done with the clock it can notify the bus using
>>> Runtime PM.
>> 
>> Is there any plan to look into the "Clock Framework" that was developed as
>> part of OMAP and extending this to make it generic for all platforms?

>I don't have any plan to do that and I heaven't heard of anyone planning to do
>it.

Thanks for the reply Rafael. I felt if we are talking about controlling a device clock from a runtime PM framework we should look at extending the Clock framework rather than re-inventing things.

Regards,
Nithish Mahalingam
