From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.24-rc5
Date: Thu, 13 Dec 2007 23:06:43 -0800
Message-ID: <20071213230643.76d196dd.akpm__23350.8284240544$1197616084$gmane$org@linux-foundation.org>
References: <200712140126.12182.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200712140126.12182.lenb@kernel.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 14 Dec 2007 01:26:11 -0500 Len Brown <lenb@kernel.org> wrote:

> please pull from: 
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git release
> 
> This will update the files shown below.
> 
> thanks!
> 
> -Len
> 
> ps. individual patches are available on linux-acpi@vger.kernel.org
> and a consolidated plain patch is available here:
> ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.24/acpi-release-20070126-2.6.24-rc5.diff.gz
> 
>  drivers/acpi/battery.c       |    2 +-
>  drivers/acpi/numa.c          |    4 ++--
>  drivers/acpi/video.c         |    4 ++--
>  drivers/misc/thinkpad_acpi.c |    4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)

What's happening with Alexey's sbs regression fixes?
