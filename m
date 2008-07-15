From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH -mm 2/2] kexec jump -v12: save/restore device
	state
Date: Tue, 15 Jul 2008 13:19:04 +0800
Message-ID: <1216099144.22944.35.camel__42114.5926615738$1216099020$gmane$org@caritas-dev.intel.com>
References: <1215401124.4660.5.camel@caritas-dev.intel.com>
	<20080714134805.GD16673@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080714134805.GD16673@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi, Vivek,

On Mon, 2008-07-14 at 09:48 -0400, Vivek Goyal wrote:
[...]
> You have cited various possible use cases of this patchset. Which is
> the specific feature you are planning to use?

I think two features are useful:

1. Kexec based hibernation
2. Do kdump then continue

> Thinking more about it, what's the compelling feature out of this list
> which makes this patchset a strong candidate for inclusion?
> 
> Regarding hibernation, Rafael does not think this is the way to go 
> for future.

I think kexec based hibernation can be a better hibernation scheme, at
least more code sharing.

Best Regards,
Huang Ying
