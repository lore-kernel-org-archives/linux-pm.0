From: david@lang.hm
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Thu, 5 Aug 2010 18:01:24 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1008051800360.25170@asgard.lang.hm>
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
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="680960-349699584-1281056485=:25170"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikOuY-q42mDRmxc-9W0uLeJeW-hiFG26WrV7CfU@mail.gmail.com>
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

--680960-349699584-1281056485=:25170
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp1.linux-foundation.org id o7612Qo1026352

On Thu, 5 Aug 2010, Brian Swetland wrote:

> On Thu, Aug 5, 2010 at 5:16 PM,  <david@lang.hm> wrote:
>>>>
>>>> So for an mp3 playback, does an Android suspend between data fetches=
?
>>>
>>> It can if the latency is long enough (which is why I point out low
>>> power audio which is usually high latency). =C2=A0For low latency (sy=
stem
>>> sounds, etc) 10-25ms between buffers it's not practical to fully
>>> suspend but we will go to the lowest power state in idle if possible.
>>
>> the playback is able to continue even with all the clocks stopped? tha=
t
>> surprises me. I would hav expected it to be able to sleep while playin=
g
>> audio, but not do a full suspend.
>
> Obviously not all clocks are stopped (the DSP and codec are powered
> and clocked, for example), but yeah we can clock gate and power gate
> the cpu and most other peripherals while audio is playing on a number
> of ARM SoC designs available today (and the past few years).

does this then mean that you have multiple variations of suspend?

for example, one where the audio stuff is left powered, and one where it=20
isn't?

David Lang
--680960-349699584-1281056485=:25170
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit


--680960-349699584-1281056485=:25170--
