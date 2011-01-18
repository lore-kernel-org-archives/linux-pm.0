From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: Resume from Memory very slow on 2.6.37+
Date: Tue, 18 Jan 2011 09:14:43 +0800
Message-ID: <AANLkTi=nGmW=3XGRzxJ1avbz-PcE_QSdVBddOM1yMiBh__6883.11997005275$1295313420$gmane$org@mail.gmail.com>
References: <AANLkTimBEnKTuR5aQyXvpZX8grQPw1eCaVgP-k9yBXhv@mail.gmail.com>
	<201101172349.06993.rjw@sisk.pl> <201101180114.42664.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101180114.42664.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <len.brown@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Jack Steiner <steiner@sgi.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 18, 2011 at 2:55 AM, Brown, Len <len.brown@intel.com> wrote:
> added Linux-acpi to cc
>
> any difference if you boot with acpi_sleep=3Dnonvs ?

That works.

On Tue, Jan 18, 2011 at 8:14 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> What happens if you replace the acpi_os_map_memory() in
>> suspend_nvs_save() with ioremap_cache() and the acpi_os_unmap_memory() in
>> suspend_nvs_free() with iounmap() ?
>
> IOW, can you please test if the patch below makes a difference?
> =A0drivers/acpi/nvs.c | =A0 =A06 +++---
> =A01 file changed, 3 insertions(+), 3 deletions(-)

That works too.

Now I have another problem which might be totally unrelated. Just
realized that my notebook can't suspend to "disk" ... used to work
last week. So, something has changed as well. May be someone has
already reported/fixed this.


Thanks,
Jeff
