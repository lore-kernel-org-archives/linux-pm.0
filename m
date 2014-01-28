From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH v3 1/2] init/do_mounts.c: ignore final \n in name_to_dev_t
Date: Tue, 28 Jan 2014 10:59:26 -0800
Message-ID: <20140128185926.5312.36635@capellas-linux>
References: <1380834638-24035-1-git-send-email-sebastian.capella@linaro.org>
 <1380834638-24035-2-git-send-email-sebastian.capella@linaro.org>
 <20131003141523.8b60ab988799af7e2b2c338b@linux-foundation.org>
 <20131003214246.24540.99218@capellas-linux>
 <20131003234735.19051.84583@capellas-linux>
 <20131010175010.17870.58060@capellas-linux>
 <20131022175414.14753.58063@capellas-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131022175414.14753.58063@capellas-linux>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Capella <sebastian.capella@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Pavel Machek <pavel@ucw.cz>, "Rafael J.  Wysocki" <rjw@rjwysocki.net>
Cc: Jens Axboe <axboe@kernel.dk>, Serge Hallyn <serge.hallyn@canonical.com>, linaro-kernel@lists.linaro.org, Stephen Warren <swarren@nvidia.com>, patches@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, linux-arm-kernel@lists.infradead.org, Al Viro <viro@zeniv.linux.org.uk>
List-Id: linux-pm@vger.kernel.org

Quoting Sebastian Capella (2013-10-22 10:54:14)
> Quoting Sebastian Capella (2013-10-10 10:50:10)
> > Quoting Sebastian Capella (2013-10-03 16:47:35)
> > > Quoting Sebastian Capella (2013-10-03 14:42:46)
> > > I looked into removing the const from the store function, but I'm not sure
> > > this is the right idea, so I'm going to shelf that for now.
> > > 
> > Below are the three options considered thus far.  Do
> > you have any additional suggestions or preferences?
> > 
> > 1) copy buffer, remove \n.
> >   - v1 patch did this
> >   - alternatively could use an array on the stack or a preallocated global
> >     Pros:
> >      . cleanest change
> >      . could use strim() proposed by Andrew
> >     Cons:
> >      . adds memcpy
> > 2) make name_to_dev_t work with readonly buffer to ignore \n
> >   - v2 and v3 patches do this
> >     Pros:
> >      . no memcpy, no big modifications to unrelated code
> >     Cons:
> >      . seems more appropriate to harden store functions to user input
> >        than name_to_dev_t.
> >      . a little complicated
> > 3) remove const from buffer and modify contents in place to remove \n
> >   - remove const from sysfs_ops.store, modify dependent definitions
> >   - remove const from kobj_attribute.store, modify dependent definitions
> >     Pros:
> >      . no memcpy
> >     Cons:
> >      . a lot of modifications
> >      . const contract to not modify the input buffer seems the right way.
> 
> Hi Andrew,
> 
> Do you have any feedback for me on this?
> 
> I'm happy do make any changes you think are correct, but I'm unsure if
> you're asking me for option #3 above.  It's quite an intrusive change,
> and changes old, established code and I'd like confirmation that's what
> you'd like before proceeding down that path.
> 
> I've submitted patches with both options #1 and #2 above.
> 
> Thanks,
> 
> Sebastian

Ping.

Sorry for the lapse in attention to this.

Could you please clarify what is needed for this to be acceptable?
I'm a little confused about what is being asked of me.

Thanks!

Sebastian
