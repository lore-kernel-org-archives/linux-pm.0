From: MyungJoo Ham <myungjoo.ham@gmail.com>
Subject: Re: runtime PM _really_ implemented on 2.6.33?
Date: Wed, 1 Jun 2011 10:13:18 +0900
Message-ID: <BANLkTi=YPMqoXoB00ET6DpkCd0HiYFhgzw@mail.gmail.com>
References: <BANLkTi=+icF79uENtEuQAOvxwJA5n8S3uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTi=+icF79uENtEuQAOvxwJA5n8S3uQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pan ruochen <panruochen@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hello Pan,

On Tue, May 31, 2011 at 2:30 PM, Pan ruochen <panruochen@gmail.com> wrote:
> Hi All,
>
> I'm working on runtime PM on 2.6.33 and find the following in
> drivers/base/platform.c
>
> ...
> #ifdef CONFIG_PM_RUNTIME
>
> int __weak platform_pm_runtime_suspend(struct device *dev)
> {
> =A0 =A0return -ENOSYS;
> };
>
> int __weak platform_pm_runtime_resume(struct device *dev)
> {
> =A0 =A0return -ENOSYS;
> };
>
> int __weak platform_pm_runtime_idle(struct device *dev)
> {
> =A0 =A0return -ENOSYS;
> };
>
> #else /* !CONFIG_PM_RUNTIME */
> ...
>
> So I guess runtime PM is not _really_ implemented on 2.6.33, for
> platform devices,
> and maybe other bus type drivers, class type drivers, isn't it?
>
> And I found a message about PM for 2.6.33 in:
> https://lists.linux-foundation.org/pipermail/linux-pm/2009-December/02339=
4.html
>
> Unfortunately, this git package is too large since my network condition i=
s poor.

Umm.. it seems that you are trying to clone the whole repository.
Then, you can try to pull some part only,  or clone with reference
(git help clone). If even loading that patch alone is too heavy for
you, I'm so sorry.

> I wonder whether there are some patches for the original 2.6.33,
> instead of a whole git project.

Why don't you simply use the generic_pm_ops
(later_kernel/drivers/base/power/generic_ops.c) for platform devices.
They are defined with __weak. Defining non weak functions should work.

>
> Best Regards
> Pan Ruochen
> May 31, 2011
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>

Cheers!
- MyungJoo
-- =

MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
