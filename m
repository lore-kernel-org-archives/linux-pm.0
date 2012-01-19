From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: Re: [PATCH v2 0/8] RFC: CPU frequency min/max as PM QoS
	params
Date: Thu, 19 Jan 2012 08:41:39 +0200
Message-ID: <8762g8qjmk.fsf@amiettinen-lnx.nvidia.com>
References: <1326697201-32406-1-git-send-email-amiettinen@nvidia.com>
	<201201172227.59080.rjw@sisk.pl>
	<87ipk9qwff.fsf@amiettinen-lnx.nvidia.com>
	<201201190010.38790.rjw@sisk.pl>
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
> On Wednesday, January 18, 2012, Antti P Miettinen wrote:
[..]
>> For the touch screen UI, the boost could be implemented as a kernel
>> module hooked with suitable event filter to the input event
>> stream. Another possibility is the UI framework in user space. Some
>> specific user space applications would also be clients.
>
> I see.
>
> However, if you use PM QoS for that as proposed, there will be only one
> misc device for the minimum CPU frequency and one for the maximum, so
> user space will only be able to specify those numbers globally, ie. for
> all CPUs in the system.  Is that your intention?

Yes - global floor/ceiling is what we want for these cases. Resource
specific constraints would be useful also. I guess the device specific
requests could be used for those but I do not have any code related to
this - yet at least :-)

	--Antti
