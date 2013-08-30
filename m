From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH RFC 1/2] PM / Hibernate: use name_to_dev_t to parse resume
Date: Fri, 30 Aug 2013 11:42:30 -0700
Message-ID: <20130830184230.28518.71814@capellas-linux>
References: <1377114413-8521-1-git-send-email-sebastian.capella@linaro.org>
 <1377114413-8521-2-git-send-email-sebastian.capella@linaro.org>
 <20130825153811.GA4795@amd.pavel.ucw.cz>
 <20130826174050.16429.7419@capellas-linux>
 <20130830113533.GA7226@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130830113533.GA7226@amd.pavel.ucw.cz>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>
Cc: len.brown@intel.com, linaro-dev@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Quoting Pavel Machek (2013-08-30 04:35:33)
> On Mon 2013-08-26 10:40:50, Sebastian Capella wrote:
> > Quoting Pavel Machek (2013-08-25 08:38:11)
> > > Is the allocation actually neccessary? At the very least this should
> > > test for NULL...
> > 
> > name_to_dev_t expects a non-const name, but the buffer passed in
> > is const.  I also am removing the '\n' if found at the end of the
> > string which would violate the const.
> 
> Fix name_to_dev_t, then. No need to do memory allocation just to work
> around const.
> 
Hi Pavel,

The issue is really Removing the \n from the user space input.  The
flow is:
const input buf -> copy to work buffer, remove newline -> name_to_dev_t

  ssize_t resume_store(..., const char *buf, size_t n)
  // copy buf, strip off trailing newline, pass to name_to_dev_t
  dev_t name_to_dev_t(char *name)

The const in the restore_store buffer comes from the function type of the
store member of the kobj_attribute.  I don't believe this should be changed.

Currently, name_to_dev_t will fail in some cases if a trailing \n is present.
Is it more appropriate to handle stripping the newline in the store
function rather than modifying name_to_dev_t to clean it up?

It seems logical for name_to_dev_t to take a const name parameter as
there should be no reason to modify the name buffer passed to it.
I'll be happy to make a patch to do this, but without hardening
name_to_dev_t against trailing newlines, it would not be neccesary for
this problem.

Thanks for your time and comments!

Sebastian
