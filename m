From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/4] cpuidle: define the enter function in
 the driver structure
Date: Tue, 10 Jul 2012 13:39:40 +0200
Message-ID: <4FFC147C.4050508@linaro.org>
References: <1341494608-16591-1-git-send-email-daniel.lezcano@linaro.org>	<1341494608-16591-2-git-send-email-daniel.lezcano@linaro.org>	<201207052238.44330.rjw@sisk.pl>
	<4FF6C4C1.7030004@linaro.org> <4FFBE7E3.8020809@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4FFBE7E3.8020809@linaro.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Rajendra Nayak <rajendra.nayak@linaro.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linaro-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On 07/10/2012 10:29 AM, Rajendra Nayak wrote:
> Hi Daniel,
>=20
> On Friday 06 July 2012 04:28 PM, Daniel Lezcano wrote:
>> The main purpose of all these cleanup patches are to move out all
>> non-data information from the cpuidle_state structure in order to add =
a
>> new api which could be 'cpuidle_register_cpu_latency(int cpu, struct
>> cpuidle_latencies latencies)'.
>=20
> So are there any technical difficulties in adding such an api with the
> non-data information being part of cpuidle_state? Or its just that you
> think the already duplicated non-data information (per state) is going
> to be duplicated much more (per state per cpu) in most cases.

Yes, it is possible. I am already working on an alternate patchset I
will post soon, but I don't like to add more things in a subsystem
before cleaning up the code when it makes sense.

When I looked at the cpuidle code, I noticed this 'enter' field was used
for the same function. With per cpu latency and using the cpuidle_state
structure, that means duplication of this field. For an x86_64
architecture with 16 cores and 4 C-states, that is 512 bytes of memory
instead of 8 bytes.

That is the same for example the 'disable' field which could be stored
in the 'flags' field as a bit instead of the moving it to the 'stats'
structure with "unsigned long long".

As the architectures tend to add more cores [1][2], that means more
memory consumption. In a very near future, we will have 100 cores in a
cpu. Assuming we have 4 C-states, that is 100 * 4 * 8 =3D 3200 bytes of
memory used for a single function. IMHO, the kernel shouldn't assume the
user must add more memory on the system.

Anyway, I will post a patchset to use the cpuidle_state per cpu.

Thanks
  -- Daniel

[1] http://www.engadget.com/2007/02/11/intel-demonstrates-80-core-process=
or/
[2] http://www.tilera.com/products/processors/TILE-Gx_Family

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
