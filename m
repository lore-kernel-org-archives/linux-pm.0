From: david@lang.hm
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Fri, 6 Aug 2010 01:07:47 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1008060106260.30564@asgard.lang.hm>
References: <alpine.DEB.2.00.1008041722060.6545@asgard.lang.hm>
	<20100805004802.GP24163@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008042208350.25170@asgard.lang.hm>
	<20100805151211.GA10080@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008050832010.25170@asgard.lang.hm>
	<AANLkTi=Yyyc-hOPbkJtsnKCVzncnFq8DPnonmyckekwm@mail.gmail.com>
	<20100805203102.GN2447@linux.vnet.ibm.com>
	<AANLkTimaaLSwVusJ=w5-QptoauBnHH0JvCvmWUr0y+KD@mail.gmail.com>
	<alpine.DEB.2.00.1008051453450.30632@asgard.lang.hm>
	<AANLkTikCCeMG=DAQ04xqkvqH9tngBWyBA5VQTD4_15xU@mail.gmail.com>
	<20100805230304.GQ2447@linux.vnet.ibm.com>
	<AANLkTinatKEBfHhMnKc5wbys13P81PKWSc+nxccgHe-Y@mail.gmail.com>
	<alpine.DEB.2.00.1008051715520.30632@asgard.lang.hm>
	<AANLkTikOuY-q42mDRmxc-9W0uLeJeW-hiFG26WrV7CfU@mail.gmail.com>
	<alpine.DEB.2.00.1008051800360.25170@asgard.lang.hm>
	<AANLkTimWqFkDWvGwVGWD94488gs+CXgpB9juwM5G11ud@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-1185624910-1281082068=:30564"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimWqFkDWvGwVGWD94488gs+CXgpB9juwM5G11ud@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, kevin granade <kevin.granade@gmail.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--680960-1185624910-1281082068=:30564
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp1.linux-foundation.org id o7688Dc5006318

On Thu, 5 Aug 2010, Brian Swetland wrote:

> On Thu, Aug 5, 2010 at 6:01 PM,  <david@lang.hm> wrote:
>> On Thu, 5 Aug 2010, Brian Swetland wrote:
>>> On Thu, Aug 5, 2010 at 5:16 PM, =C2=A0<david@lang.hm> wrote:
>>>>>>
>>>>>> So for an mp3 playback, does an Android suspend between data fetch=
es?
>>>>>
>>>>> It can if the latency is long enough (which is why I point out low
>>>>> power audio which is usually high latency). =C2=A0For low latency (=
system
>>>>> sounds, etc) 10-25ms between buffers it's not practical to fully
>>>>> suspend but we will go to the lowest power state in idle if possibl=
e.
>>>>
>>>> the playback is able to continue even with all the clocks stopped? t=
hat
>>>> surprises me. I would hav expected it to be able to sleep while play=
ing
>>>> audio, but not do a full suspend.
>>>
>>> Obviously not all clocks are stopped (the DSP and codec are powered
>>> and clocked, for example), but yeah we can clock gate and power gate
>>> the cpu and most other peripherals while audio is playing on a number
>>> of ARM SoC designs available today (and the past few years).
>>
>> does this then mean that you have multiple variations of suspend?
>>
>> for example, one where the audio stuff is left powered, and one where =
it
>> isn't?
>
> While the cpu (and the bulk of the system) is suspended, it's not
> uncommon for some peripherals to continue to operate -- for example a
> cellular radio, gps, low power audio playback, etc.  Details will vary
> depending on the SoC and board design.  It's not so much a different
> suspend mode (the system is still suspended), just a matter of whether
> a peripheral can operate independently (and if it is lower power for
> it to do so).

this helps, but isn't quite what I was trying to ask.

on a given piece of hardware, does suspend always leave the same=20
peripherals on, or do you sometimes power more things down than other=20
times when suspending?

David Lang
--680960-1185624910-1281082068=:30564
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--680960-1185624910-1281082068=:30564--
