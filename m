From: Theodore Tso <tytso@mit.edu>
Subject: Re: [TuxOnIce-devel] [SUSPECTED SPAM] Re: Proposal for a
	new algorithm for reading & writing a hibernation image.
Date: Sat, 5 Jun 2010 08:59:53 -0400
Message-ID: <88D03BC9-5E85-482D-9431-F1CE4C958C9B__22557.4908349246$1275742897$gmane$org@mit.edu>
References: <9rpccea67yy402c975fqru8r.1275576653521@email.android.com>
	<4C0994B9.6070406@crca.org.au>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C0994B9.6070406@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, TuxOnIce-devel <tuxonice-devel@tuxonice.net>
List-Id: linux-pm@vger.kernel.org


On Jun 4, 2010, at 8:05 PM, Nigel Cunningham wrote:
>> 2mb pages will probably present a problem, as will bat mappings on powerpc.
> 
> I have the idea that 2MB pages are only used for the kernel text and read only data. Is that right? If so, perhaps they can just be unconditionally copied (so that we can restore the image if a different kernel is booted) and wouldn't need any page protection. Does that sound right?

No, hugepages are available for use by userspace programs.  

See: https://lwn.net/Articles/374424/

- Ted
