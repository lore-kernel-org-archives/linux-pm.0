From: Kevin Hilman <khilman@ti.com>
Subject: Re: [RFC PATCH V3 4/4] cpuidle: Single/Global
	registration of idle states
Date: Fri, 22 Apr 2011 16:06:42 -0700
Message-ID: <871v0tvqbh.fsf__3609.76047018102$1303513745$gmane$org@ti.com>
References: <20110420065445.332.13688.stgit@tringupt.in.ibm.com>
	<20110420065608.332.30043.stgit@tringupt.in.ibm.com>
	<87k4eo6d5m.fsf@ti.com> <4DAFB847.50404@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4DAFB847.50404@linux.vnet.ibm.com> (Trinabh Gupta's message of
	"Thu, 21 Apr 2011 10:23:27 +0530")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Trinabh Gupta <trinabh@linux.vnet.ibm.com>
Cc: venki@google.com, davinci-linux-open-source@linux.davincidsp.com, ak@linux.intel.com, len.brown@intel.com, peterz@infradead.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, arjan@linux.intel.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Trinabh,

Trinabh Gupta <trinabh@linux.vnet.ibm.com> writes:

[...]

> I just wanted to get comments on the design and understand how it
> affects various architectures in question. It looks to me as if the
> design should be okay and infact better for architectures like ARM
> since they do not have different idle states for different cpus and
> thus do not require per-cpu registration.  Global registration would
> work and be simpler; please correct me if I am wrong.

Yes, I agree that the new design is better, I especially like that it's
more clear (and expected) that final state decision making is to be done
directly in the driver without the back-and-forth in the current setup.

Thanks,

Kevin
