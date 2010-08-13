From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
 take three
Date: Fri, 13 Aug 2010 13:43:08 +0300
Message-ID: <AANLkTimCrOqizJ7LL7t3hN=wMF_oxNFPxKbjWz_AsZ_U__38575.1606816941$1281696241$gmane$org@mail.gmail.com>
References: <AANLkTimahmGikeai8QnAxCy45deT00-6T7h-eA-NqL4G@mail.gmail.com>
	<20100812010612.GL2516@linux.vnet.ibm.com>
	<AANLkTinVV1NVHFPeO0p_e2pCtNwTNB932q9tbu9MMD3_@mail.gmail.com>
	<20100812034435.GA7403@linux.vnet.ibm.com>
	<AANLkTi=RD=eM_gpc7FfRq0923sUbARmZ2+4-m+fLibYC@mail.gmail.com>
	<E3F3D3E1-4DF7-47E3-895D-95F6BC22CCC4@mit.edu>
	<AANLkTikcoWfmL-XfYbFeYdVtU9GC6_LtVSSB2H6GcedA@mail.gmail.com>
	<20100812174303.GD2524@linux.vnet.ibm.com>
	<AANLkTim1U6QpRyfwYCq2uRA=7-a8ryfDrzv5VCqmHnyB@mail.gmail.com>
	<AANLkTinNxZoMab=tG9KXJ9n_nxB1dXHkfk-7xUMWXACW@mail.gmail.com>
	<20100812195224.GA6370@comet.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100812195224.GA6370@comet.dominikbrodowski.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>, Felipe Contreras <felipe.contreras@gmail.com>, david@lang.hm, Theodore Tso <tytso@mit.edu>, peterz@infradead.org, linux-kern
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 12, 2010 at 10:52 PM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> On Thu, Aug 12, 2010 at 12:48:48PM -0700, Brian Swetland wrote:
>> I guess I don't understand,
>
> I guess I don't, either -- there are some parts of the kernel used by only a
> handful of users... and here we speak about million users...

A driver that sits in a corner and doesn't show in the 'menuconfig' of
most people and is used by small fraction of user-space applications
(perhaps even 0) is just fine. But we are talking of something
centric, that can be enabled on all systems, and that affects all
user-space.

-- 
Felipe Contreras
