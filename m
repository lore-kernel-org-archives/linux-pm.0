From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [ANNOUNCE] cpupowerutils - cpufrequtils extended
	with quite some features
Date: Fri, 11 Mar 2011 15:56:01 +0000
Message-ID: <AANLkTimFg+uYGbSi=Ci-+_e89TgLkyMB7PAJcnt7mzTc__10785.968337632$1300114986$gmane$org@mail.gmail.com>
References: <201103111247.00212.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103111247.00212.trenn@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Thomas Renninger <trenn@suse.de>
Cc: Mattia Dongili <malattia@linux.it>, dri-devel@lists.freedesktop.org, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org, linux@dominikbrodowski.net, discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, power@bughost.org
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 11, 2011 at 11:46 AM, Thomas Renninger <trenn@suse.de> wrote:
> Why is there need for another tool?
> -----------------------------------
>
> CPU power consumption vs performance tuning is not about
> CPU frequency switching anymore for quite some time.
> Deep sleep states, traditional dynamic frequency scaling and
> hidden turbo/boost frequencies are tight close together and
> depend on each other. The first two exist on different architectures
> like PPC, Itanium and ARM the latter only on X86.
> On X86 the APU (CPU+GPU) will only run most efficiently if CPU
> and GPU has proper power management in place.
>
> Users and Developers want to have *one* tool to get an overview what their
> system supports and to monitor and debug CPU power management in detail.
>
> The tool should compile and work on as much architectures as
> possible.
>

Hi Thomas,
Do you think handling really vendor specific "boosts" like EeePC's SHE
is in cpupower scope ?
Still, it would not solve the issue of setting SHE mode in a standard
way, or associating it with a governor.
Thanks,

-- 
Corentin Chary
http://xf.iksaif.net
