From: Pan ruochen <panruochen@gmail.com>
Subject: runtime PM _really_ implemented on 2.6.33?
Date: Tue, 31 May 2011 13:30:29 +0800
Message-ID: <BANLkTi=+icF79uENtEuQAOvxwJA5n8S3uQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi All,

I'm working on runtime PM on 2.6.33 and find the following in
drivers/base/platform.c

...
#ifdef CONFIG_PM_RUNTIME

int __weak platform_pm_runtime_suspend(struct device *dev)
{
    return -ENOSYS;
};

int __weak platform_pm_runtime_resume(struct device *dev)
{
    return -ENOSYS;
};

int __weak platform_pm_runtime_idle(struct device *dev)
{
    return -ENOSYS;
};

#else /* !CONFIG_PM_RUNTIME */
...

So I guess runtime PM is not _really_ implemented on 2.6.33, for
platform devices,
and maybe other bus type drivers, class type drivers, isn't it?

And I found a message about PM for 2.6.33 in:
https://lists.linux-foundation.org/pipermail/linux-pm/2009-December/023394.html

Unfortunately, this git package is too large since my network condition is poor.
I wonder whether there are some patches for the original 2.6.33,
instead of a whole git project.

Best Regards
Pan Ruochen
May 31, 2011
