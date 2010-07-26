From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86, acpi: handle xapic/x2apic at same time
Date: Mon, 26 Jul 2010 15:21:01 -0700
Message-ID: <4C4E0A4D.3060305__30285.8987627134$1280183046$gmane$org@zytor.com>
References: <4C4E047D.6030000@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C4E047D.6030000@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <len.brown@intel.com>, Feng Tang <feng.tang@intel.com>, Suresh Siddha <suresh.b.siddha@intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, David Rientjes <rientjes@google.com>, Jean Delvare <khali@linux-fr.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 07/26/2010 02:56 PM, Yinghai Lu wrote:
> 
> one system have mixing xapic and x2apic entries in MADT and SRAT.
> 

Any way you could provide a name of this system, and/or an acpidump of it?

Thanks,

	-hpa
