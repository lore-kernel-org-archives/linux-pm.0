From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: [PATCH 0/11] ACPI: Fixes and cleanups related to
	iomaps management
Date: Fri, 21 Jan 2011 00:06:55 +0800
Message-ID: <AANLkTikVRHfu2KhH4yi2VerkRXBdCODedCDORmpEzRXO__18275.5234804519$1295540322$gmane$org@mail.gmail.com>
References: <201101201226.41021.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101201226.41021.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 20, 2011 at 7:26 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:

> [10/11] - Make the NVS code use existing iomaps if possible.

Seems ok.

> [11/11] - (cleanup) Remove an unnecessary field from struct nvs_page.

This seems to have an issue. Notebook tries to suspend ... then resume
immediately.

> The patches have been tested on HP nx6325, Toshiba Portege R500 and Acer
> Ferrari One without causing any visible problems to happen. =A0Also Jeff =
has
> tested [1/11] and [2/11] and he reports that they fix the synchronize_rcu=
()
> problem for him. =A0[Jeff, can you test the whole series, please, and see=
 if
> it doesn't introduce any new issues, [10/11] in particular?]

So, everything seems ok except 11/11.


Jeff.
