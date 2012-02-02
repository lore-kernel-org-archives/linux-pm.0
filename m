From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: Re: [PATCH v2 0/8] RFC: CPU frequency min/max as PM QoS
	params
Date: Thu, 02 Feb 2012 08:06:38 +0200
Message-ID: <87vcnp93bl.fsf@amiettinen-lnx.nvidia.com>
References: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com>
	<201201192315.22590.rjw@sisk.pl>
	<87d3acf2jh.fsf@amiettinen-lnx.nvidia.com>
	<201201230043.46436.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: cpufreq@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

"Rafael J. Wysocki" <rjw@sisk.pl> writes:
> On Sunday, January 22, 2012, Antti P Miettinen wrote:
[..]
>> Seems that the device specific constraints are not yet in use in
>> 3.3-rc1, or am I not looking hard enough?
>
> They are in use through generic PM domains (drivers/base/power/domain*.c
> and friends) and ARM/shmobile uses those.
>
> Thanks,
> Rafael

Sorry for the delay - got pre-empted by other stuff. I took a look at
the per device constraints. Do I understand it correctly that the idea
is that there is only one constraint per device? If we want to make
frequency and latency per CPU I guess we'd need separate constraints
associated with the CPU device. Or do I misunderstand something?

Or would global CPU frequency be more in line with global CPU latency
after all?

	--Antti
