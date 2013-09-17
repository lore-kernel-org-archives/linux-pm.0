From: Sebastian Capella <sebastian.capella-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 1/2] PM / Hibernate: use name_to_dev_t to parse resume
Date: Tue, 17 Sep 2013 13:50:21 -0700
Message-ID: <20130917205021.20736.5257@capellas-linux>
References: <1377114413-8521-1-git-send-email-sebastian.capella@linaro.org>
 <1377114413-8521-2-git-send-email-sebastian.capella@linaro.org>
 <20130825153811.GA4795@amd.pavel.ucw.cz>
 <20130826174050.16429.7419@capellas-linux>
 <20130830113533.GA7226@amd.pavel.ucw.cz>
 <20130830184230.28518.71814@capellas-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <20130830184230.28518.71814@capellas-linux>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
 <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
 <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Sebastian Capella <sebastian.capella-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, rjw-+BtOjEMDT1ZEFMq0/Lb3/3WsBbEqB2P/@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, @lists.linaro.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Quoting Sebastian Capella (2013-08-30 11:42:30)
> Quoting Pavel Machek (2013-08-30 04:35:33)
> > On Mon 2013-08-26 10:40:50, Sebastian Capella wrote:
> > > Quoting Pavel Machek (2013-08-25 08:38:11)
> > > > Is the allocation actually neccessary? At the very least this should
> > > > test for NULL...
> > > 
> > > name_to_dev_t expects a non-const name, but the buffer passed in
> > > is const.  I also am removing the '\n' if found at the end of the
> > > string which would violate the const.
> > 
> > Fix name_to_dev_t, then. No need to do memory allocation just to work
> > around const.
> > 
> Hi Pavel,
> 
> The issue is really Removing the \n from the user space input.  The
> flow is:
> const input buf -> copy to work buffer, remove newline -> name_to_dev_t
> 
>   ssize_t resume_store(..., const char *buf, size_t n)
>   // copy buf, strip off trailing newline, pass to name_to_dev_t
>   dev_t name_to_dev_t(char *name)
> 
> The const in the restore_store buffer comes from the function type of the
> store member of the kobj_attribute.  I don't believe this should be changed.
> 
> Currently, name_to_dev_t will fail in some cases if a trailing \n is present.
> Is it more appropriate to handle stripping the newline in the store
> function rather than modifying name_to_dev_t to clean it up?
> 
> It seems logical for name_to_dev_t to take a const name parameter as
> there should be no reason to modify the name buffer passed to it.
> I'll be happy to make a patch to do this, but without hardening
> name_to_dev_t against trailing newlines, it would not be neccesary for
> this problem.
> 
> Thanks for your time and comments!
> 

Hi Pavel,

Do you have any more feedback regarding leaving the strndup?

Thanks!

Sebastian
