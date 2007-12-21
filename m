From: Nigel Cunningham <nigel@nigel.suspend2.net>
Subject: Re: [PATCH 0/3 -mm] kexec jump -v8
Date: Fri, 21 Dec 2007 19:35:27 +1100
Message-ID: <476B7ACF.8020602__35932.8827391893$1198226213$gmane$org@nigel.suspend2.net>
References: <1198222399.1965.15.camel@caritas-dev.intel.com>
Reply-To: nigel@nigel.suspend2.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1198222399.1965.15.camel@caritas-dev.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi.

Huang, Ying wrote:
> This patchset provides an enhancement to kexec/kdump. It implements
> the following features:
> 
> - Backup/restore memory used both by the original kernel and the
>   kexeced kernel.

Why the kexeced kernel as well?

[...]

> The features of this patchset can be used as follow:
> 
> - Kernel/system debug through making system snapshot. You can make
>   system snapshot, jump back, do some thing and make another system
>   snapshot.

Are you somehow recording all the filesystem changes after the first
snapshot? If not, this is pointless (you'll end up with filesystem
corruption).

[...]

> - Cooperative multi-kernel/system. With kexec jump, you can switch
>   between several kernels/systems quickly without boot process except
>   the first time. This appears like swap a whole kernel/system out/in.

How is this useful to the end user?

Regards,

Nigel
