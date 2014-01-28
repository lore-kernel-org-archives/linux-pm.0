From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH v3 1/2] init/do_mounts.c: ignore final \n in name_to_dev_t
Date: Tue, 28 Jan 2014 12:58:30 -0800
Message-ID: <20140128205830.14275.80319@capellas-linux>
References: <1380834638-24035-1-git-send-email-sebastian.capella@linaro.org>
 <1380834638-24035-2-git-send-email-sebastian.capella@linaro.org>
 <20131003141523.8b60ab988799af7e2b2c338b@linux-foundation.org>
 <20131003214246.24540.99218@capellas-linux>
 <20131003234735.19051.84583@capellas-linux>
 <20131010175010.17870.58060@capellas-linux>
 <20131022175414.14753.58063@capellas-linux>
 <20140128185926.5312.36635@capellas-linux>
 <20140128125442.4bac748945b404179deb58ba@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140128125442.4bac748945b404179deb58ba@linux-foundation.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jens Axboe <axboe@kernel.dk>, Serge Hallyn <serge.hallyn@canonical.com>, linaro-kernel@lists.linaro.org, Stephen Warren <swarren@nvidia.com>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@linaro.org, "Rafael J.  Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org, Al Viro <viro@zeniv.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

Quoting Andrew Morton (2014-01-28 12:54:42)
> The problem is that kernel/power/hibernate.c:resume_store() is handed a
> newline-terminated string, yes?  And if it blindly hands that string
> over to name_to_dev_t(), name_to_dev_t() fails because the string is
> wrong.
> 
> This is an oddity of the sysfs->kernel interface and altering
> name_to_dev_t doesn't really seem appropriate for this problem - it
> would be better to fix the caller to pass in the correct string.
> 
> Something like...
> 
> /*
>  * Clean up a string which may have leading and/or trailing whitespace (as
>  * defined by isspace()) by trimming off that whitespace.  Returns an address
>  * which the caller must kfree(), or NULL on error.
>  */
> char *strim_copy(const char *s, gfp_t gfp)
> {
>         char *ret = kstrdup(skip_spaces(s), gfp);
> 
>         if (ret)
>                 strim(ret);
>         return ret;
> }
> EXPORT_SYMBOL(strim_copy);

Hi Andrew,

Thanks, this is similar, but tidier than my original patch.  I'll
fix up and repost the patch with a fix like what you're proposing.

Thanks!

Sebastian
