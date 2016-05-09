From: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Subject: Re: I2C driver for LTC1760 dual smart battery system manager
Date: Mon, 09 May 2016 21:30:03 +0200
Message-ID: <1462822203.30623.11.camel@amnesix>
References: <1461870951.6670.33.camel@amnesix>
	 <500153f6-32a9-3dd2-6bdc-cf96b6afde95@electromag.com.au>
	 <1462562607.17299.26.camel@amnesix>
	 <4fe0360a-304e-944a-3c77-9e5a701552de@electromag.com.au>
	 <86aa60dc-1146-9eee-01e1-4388be7981f1@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from schneider-inet.de ([85.214.76.205]:46822 "EHLO
	h1714509.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001AbcEITaQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 9 May 2016 15:30:16 -0400
In-Reply-To: <86aa60dc-1146-9eee-01e1-4388be7981f1@axentia.se>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Rosin <peda@axentia.se>, Phil Reid <preid@electromag.com.au>
Cc: linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Greetings,

Am Montag, den 09.05.2016, 10:00 +0200 schrieb Peter Rosin:
> Hi!
> 
> [adding acpi people]
> 
> On 2016-05-09 03:41, Phil Reid wrote:
> > G'day Karl,
> > On 7/05/2016 03:23, Karl-Heinz Schneider wrote:
> >> Hi Phil
> >>
> >> Am Freitag, den 06.05.2016, 15:27 +0800 schrieb Phil Reid:
> >>> G'day Karl
> >>> On 29/04/2016 03:15, Karl-Heinz Schneider wrote:
> >>>>
> >>>> I have written an Kernel driver for the LTC1760 which is basically an
> >>>> charger which can handle 2 batteries. Datasheet can be found at
> >>>> http://www.linear.com/product/LTC1760
> >>> They're nice chips.
> >>>>
> >>>> However, the device has one speciality: Hence it handles two smart
> >>>> batteries, which are expected to sit on I2C address 0x0b, it implements
> >>>> an i2c mux. As the device does so, my driver does also (using
> >>>> i2c_add_mux_adapter() call).
> >>>> Further more, Linux already ships with an driver capable to talk to
> >>>> these smart battery chips, namely "sbs-battery".
> >>>>
> >>>> I currently using device tree to bind the LTC1760 to the smbus it sits
> >>>> on and further to define the i2c-lines it implements as well as the
> >>>> batteries sitting on the two muxed lines.
> >>>>
> >>>> Would you say this approach is technically right? The LTC expects SBS
> >>>> compliant batteries connected to it, which implies a standard minimal
> >>>> interface. But binding the batteries via device tree gives the user the
> >>>> freedom to specify a more specialized driver.
> >>>> On the other hand one could argue that if the LTC is present, also
> >>>> batteries are (potentially) present and the LTC driver is responsible to
> >>>> read the related registers and provide proper PM attributes. Personally
> >>>> I don't like to rewrite or copy code wich works just fine...
> >>>>
> >>>
> >>> I've been writing a driver for the same chip :).
> >>> My system has 2 ltc1760 for a total of 4 batteries.
> >>> Haven't completed it as yet so hadn't posted, but got it talking to the batteries.
> >>> I implemented an I2c mux in the driver and just attached two sbs-battery's to it in the device tree.
> >>> I think the mux is the way to go, simple and reuses existing code.
> >>>
> >>
> >> Think so too.
> 
> I also think the muxing in ltc1760 appears to fit nicely with the
> i2c-mux framework. But I only had a cursory look...
> 
> >>> FYI, if you didn't find it there is an acpi only driver for the ltc1760 in the kernel.
> >>> But I could see a way to make it work with device trees. It enumerates it's own
> >>> batteries.
> >>
> >> Indeed I failed to find it. Looked through drivers to find something
> >> similar. How is it named?
> > It wrapped up in the acpi/sbs.c driver. Does specifically mention the ltc1760.
> > It doesn't really do much with the charger other than use it to enumerate number of batteries
> > and switch the i2c mux.
> > Search for manager_present and you'll find the relevant code.
> 
> I had a look at the acpi code you point to, and it appears to be
> racy.
> 
> It registers an attribute (alarm_attr) for every batteriy with the
> "store" function set to acpi_battery_alarm_store, which calls
> acpi_battery_set_alarm, which -- without any locking -- checks if
> the mux is set correctly, updates the mux if not, and then writes
> to the battery.
> 
> I see other code-paths that also appear to touch the mux in
> similar ways (i.e. without locking) but I didn't really look any
> further than the above, which seems to be enough of a real
> problem if separate users write to the alarm attr of batteries
> connected to the same manager.
> 
> The suggested fix is to register the ltc1760 mux as a real
> i2c-mux, which would probably be easiest when the i2c-mux locking
> update scheduled for 4.7 has landed (presently available in the
> i2c for-next branch and in linux-next).

Then I will take a look at this new stuff. For the device I target I'm
forced to use an old 3.14 Kernel :-(.

At the moment I'm doing some further tests, especially the thing with
read/write failures which do happen from time to time does bother me
(ltc1760 does stretch i2c clock). Once I'm happy with it I will post
code.
> 
> Cheers,
> Peter

Greetings
Karl-Heinz

