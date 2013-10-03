From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH v3 1/2] init/do_mounts.c: ignore final \n in name_to_dev_t
Date: Thu, 03 Oct 2013 14:42:46 -0700
Message-ID: <20131003214246.24540.99218@capellas-linux>
References: <1380834638-24035-1-git-send-email-sebastian.capella@linaro.org>
 <1380834638-24035-2-git-send-email-sebastian.capella@linaro.org>
 <20131003141523.8b60ab988799af7e2b2c338b@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131003141523.8b60ab988799af7e2b2c338b@linux-foundation.org>
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
Cc: Jens Axboe <axboe@kernel.dk>, Serge Hallyn <serge.hallyn@canonical.com>, linaro-kernel@lists.linaro.org, Stephen Warren <swarren@nvidia.com>, patches@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, linux-arm-kernel@lists.infradead.org, Al Viro <viro@zeniv.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

Quoting Andrew Morton (2013-10-03 14:15:23)
> On Thu,  3 Oct 2013 14:10:37 -0700 Sebastian Capella <sebastian.capella@linaro.org> wrote:
> 
> > Enhance name_to_dev_t to handle trailing newline characters
> > on device paths.  Some inputs to name_to_dev_t may come from
> > userspace where oftentimes a '\n' is appended to the path.
> > Added const to the name buffer in both the function
> > declaration and the prototype to reflect input buffer
> > handling.
> > 
> > By handling trailing newlines in name_to_dev_t, userspace
> > buffers may be directly passed to name_to_dev_t without
> > modification.
> 
> We have lib/string.c:strim() - perhaps this patch would be
> neater if it were to use it?

Hi Morton,

I was intending to respect the const handling of the input buffer.

The actual buffer in this case is not really const as it comes from
the file buffering, but removing the const requires changing the
store function defined in the kobj_attribute, and would propagate
to many areas in the kernel.

Modifying the buffer and removing the const was also suggested by Pavel.
After some discussion I posted this version which did not change the
buffer or the prototype.

Please let me know if the preference is to modify the store function
definition.

I'll prepare a patchset that removes the consts to see how much is
changed.

Thanks,

Sebastian
