From: Dave Hansen <dave@linux.vnet.ibm.com>
Subject: Re: Suspend/resume regressions on Lenovo S10-3
Date: Mon, 11 Jun 2012 07:57:35 -0700
Message-ID: <4FD6075F.5010307@linux.vnet.ibm.com>
References: <4FC2DA8C.7050401@linux.vnet.ibm.com>
	<4FCF5249.2070600@linux.vnet.ibm.com>
	<4FD5F329.2090302@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4FD5F329.2090302@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: Kevin Hilman <khilman@ti.com>, Arnd Bergmann <arnd@arndb.de>, Linux PM mailing list <linux-pm@vger.kernel.org>, "Tomas M." <tmezzadra@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, preeti@linux.vnet.ibm.com, linux-pm@lists.linux-foundation.org, Ferenc Wagner <wferi@niif.hu>, Arjan van de Ven <arjan@linux.intel.com>, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

On 06/11/2012 06:31 AM, Srivatsa S. Bhat wrote:
> Hi Dave,
> 
> On 06/06/2012 06:21 PM, Deepthi Dharwar wrote:
> 
>> On 05/28/2012 07:23 AM, Dave Hansen wrote:
>>
>>> I have a Lenovo S10-3 Atom netbook.  It's always had some amount of
>>> trouble working with the intel_idle driver, so I usually compile that
>>> out an use the acpi one.
> 
> 
> What problem did you face with intel_idle driver? Is it suspend/resume
> related?

With intel_idle, sometimes it won't boot, others it won't suspend/resume:

  https://bugs.launchpad.net/ubuntu/+source/linux/+bug/674075

I'm actually not sure how it behaves on current kernels.
