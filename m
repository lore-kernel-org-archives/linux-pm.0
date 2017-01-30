From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 0/2] drm amdgpu/radeon: clean up d3_delay usage
Date: Mon, 30 Jan 2017 14:40:51 -0600
Message-ID: <20170130203822.31891.22461.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?utf-8?b?S8O2bmln?= <christian.koenig@amd.com>
Cc: linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, Maarten Lankhorst <maarten.lankhorst@canonical.com>
List-Id: linux-pm@vger.kernel.org

amdgpu doesn't need to touch pdev->d3_delay at all.

radeon has a d3_delay quirk for MacBook Pro, but it only affects
radeon_switcheroo_set_state().  I think it should affect wakeups done by
the PCI core as well.

---

Bjorn Helgaas (2):
      drm/amdgpu: remove unnecessary save/restore of pdev->d3_delay
      drm/radeon: make MacBook Pro d3_delay quirk more generic


 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |    4 ----
 drivers/gpu/drm/radeon/radeon_device.c     |   12 ------------
 drivers/pci/quirks.c                       |   13 +++++++++++++
 3 files changed, 13 insertions(+), 16 deletions(-)
