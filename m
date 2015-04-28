From: Mason <slash.tmp@free.fr>
Subject: Using a temperature sensor with 1-bit output for CPU throttling
Date: Tue, 28 Apr 2015 13:27:01 +0200
Message-ID: <553F6E85.5090402@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp2-g21.free.fr ([212.27.42.2]:13378 "EHLO smtp2-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965244AbbD1L1G (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 28 Apr 2015 07:27:06 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: cpufreq <cpufreq@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>

Hello everyone,

The SoC I'm working on provides a temperature sensor (NXP) in the CPU b=
lock.
The sensor seems to be very primitive, so I wanted to ask experienced p=
eople
what would be the best way to use it from Linux.

General Description
"The sensor generates an output signal that indicates if the die temper=
ature
exceeds a programmable threshold. This makes it particularly suitable f=
or
detecting overheating."

So it seems that the original purpose of this sensor was to periodicall=
y
check that the temperature has not exceeded a given threshold.

- Is the CPU temp higher than 100=C2=B0C ?
- No.
- OK. Business as usual.

(1 second later)
- Is the CPU temp higher than 100=C2=B0C ?
- Yes.
- Uh-oh! I need to do something about it.


Basic Functions
"The temp sensor uses a bandgap type of circuit to compare a voltage wh=
ich
has a negative temperature coefficient with a voltage that is proportio=
nal
to absolute temperature. A resistor bank allows 40 different temperatur=
e
thresholds to be selected and the logic output 'out_temperature' will t=
hen
indicate whether the actual die temperature lies above or below the sel=
ected
threshold."

The available thresholds seem to be chosen somewhat arbitrarily:

  -45.1, -39.7, -33.7, -29.4, -24.4, -20.4, -15.4, -10.1,
  -6.4, -1.4, 3.6, 7.6, 12.9, 16.6, 20.6, 25.6, 30.9,
  34.9, 38.6, 43.9, 48.9, 52.9, 57.9, 61.9, 66.9, 70.9,
  76.3, 81.3, 85.3, 90.3, 95.3, 98.9, 102.9, 108.3, 111.9,
  117.3, 122.3, 126.3, 131.3, 135.3, 139.3

The spacing between values seems arbitrary also.
(Is there an underlying physical explanation?)

I'm not sure that there is much point in testing for temperatures lower
than 50=C2=B0C ? (I'm told that the SoC can reliably function up to 125=
=C2=B0C.)

Do higher temperatures shorten the lifespan of a component?
In other words, would a CPU running 24/7 at 100=C2=B0C "break" sooner
than one running 24/7 at 50=C2=B0C ?


Characteristics

Symbol      Parameter             Min  Typ  Max  Unit

(Operating conditions)
Tjunc      Junction temperature   -40   25   125  =C2=B0C
Vdd        Supply voltage         1.0  1.1  1.26   V

(Normal operating mode)
Idd         Supply current              50    60  =CE=BCA
Vbandgapref Ref output voltage   0.72  0.8  0.88   V
=E2=88=86outtemp    Absolute Temp               =C2=B12   =C2=B110  =C2=
=B0C
            threshold error
T_res       Temp resolution        3    4.5    7  =C2=B0C


Given the semantics of the temperature sensor hardware block, I was
tempted to implement something along these lines:

Create a kernel thread that runs periodically (e.g. every second)
to check if the temperature is above 100=C2=B0C.
- If not, do nothing
- If yes, somehow prevent the CPU from using the highest frequencies
defined in cpufreq's freq table
(They are 1000, 500, 333, 200, 100 MHz)

Is that a sensible approach?
Is there a way to implement this using the thermal framework?

Or am I looking at this wrong, and things should be done a
different way? (I'm using 3.14 by the way.)

I suppose I could perform some kind of binary search to zoom in
on the current threshold (although it might change during the
measurements, so I'd rather not go there.)

Regards.
